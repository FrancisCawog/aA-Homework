require "byebug"
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14){Array.new}
    @cups.each_with_index do |cup, i|
      if i == 6 || i == 13
        cups[i] = []
      else
        cups[i] += place_stones
      end
    end
  end

  def place_stones
    stones = []
    4.times do 
      stones << :stone
    end 
    stones
  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' if start_pos < 0 || start_pos > 14
    raise 'Starting cup is empty' if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []

    i = start_pos
    while stones.length > 0
      i += 1
      i = 0 if i == 14
      if i == 6 && current_player_name == @name1
        @cups[6] << stones.shift 
      elsif i == 13 
        @cups[13] << stones.shift if current_player_name == @name2
      else
        @cups[i] << stones.shift
      end
    end
    
    render
    next_turn(i)
  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      return :prompt
    elsif @cups[ending_cup_idx].count == 1
      return :switch
    else
      return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..6].all? {|cup| cup.length < 1 } || @cups[7..12].all? {|cup| cup.length < 1}
  end

  def winner
    p_1 = @cups[6].count
    p_2 = @cups[13].count

    if p_1 > p_2
      return @name1
    elsif p_2 > p_1
      return @name2
    else
      return :draw
    end
  end
end