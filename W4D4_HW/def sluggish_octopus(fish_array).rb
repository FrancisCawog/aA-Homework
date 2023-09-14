def sluggish_octopus(fish_array)
    fish_array.each do |fish1, i1|
        longest_fish = true


        fish_array.each do |fish2, i2|
            longest_fish = false if i1 < i2 && fish2.length > fish1.length
        end

        return fish1 if longest_fish
    end
end

class Array 
    def dominant_octopus(&prc)
    prc ||= Proc.new {|a, b| a <=> b}

    return self if self.length <= 1

    middle = self.length / 2
    left = self[0...middle].dominant_octopus(&prc)
    right = self[middle..-1].dominant_octopus(&prc)

    Array.merge(
        left,
        right, 
        &prc
    )

    def self.merge(left, right, &prc)
        merged = []

        until left.empty? || right.empty?
            if prc.call(left[0], right[0]) != -1
                merged << left.shift
            else
                merged << right.shift
            end
        end
        merged + left + right
    end
end

def clever_octopus(fish_array)
    prc = Proc.new{|a,b| b.length <=> a.length}
    fish_array.dominant_octopus(&prc)[0]
end

def dancing_octopus(fish_array)
    longest_fish = fish_array.shift

    fish_array.each do |fish|
        if fish.length > longest_fish.length
            longest_fish = fish
        end
    end
    longest_fish
end

def slow_dance(direction, tiles_array)
    tiles_array.each_with_index do |tile, i|
        return index if tile == direction
    end
end

def fast_dance(direction, tiles_hash)
    tiles_hash[direction]
end