class Array
  # Write a new `Array#merge_sort` method; it should not modify the array it is
  # called on, but create a new sorted array.
  # **Do NOT use the built-in `Array#sort` or `Array#sort_by` methods in your
  # implementation.**

  def merge_sort(&prc)
    prc ||= Proc.new{|a,b| a <=> b}
    return self if self.length < 2

    middle = self.length / 2
    left = self[0...middle]
    right = self[middle..-1]

    Array.merge(
      left.merge_sort(&prc),
      right.merge_sort(&prc),
      &prc
    )
  end

  private
  def self.merge(left, right, &prc)
    new_arr = []

    until left.empty? || right.empty?
      if prc.call(left[0], right[0]) == -1
        new_arr << left.shift
      else
        new_arr << right.shift
      end
    end
    new_arr + left + right
  end
end

class Array
  # Write a new `Array#pair_sum(target)` method that finds all pairs of
  # positions where the elements at those positions sum to the target.

  # N.B.: order matters. You want each of the pairs to be sorted with the
  # smaller index before bigger index. You want the array of pairs to be
  # sorted "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def pair_sum(target)
    new_arr = []

    self.each.each_with_index do |num1, i1|
      self.each_with_index do |num2, i2|
        if i1 < i2 && num1 + num2 == target
          new_arr << [i1, i2]
        end
      end
    end
    new_arr
  end
end

class Array
  # Write a method that flattens an array to the specified level. If no level
  # is specified, it should entirely flatten nested arrays.

  # **Do NOT use the built-in `Array#flatten` method in your implementation.**

  # Examples:
  # Without an argument:
  # [["a"], "b", ["c", "d", ["e"]]].my_flatten = ["a", "b", "c", "d", "e"]

  # When given 1 as an argument:
  # (Flattens the first level of nested arrays but no deeper.)
  # [["a"], "b", ["c", "d", ["e"]]].my_flatten(1) = ["a", "b", "c", "d", ["e"]]

  def my_flatten(level = nil)
    holder = []

    self.each do |ele|
      if ele.is_a?(Array) && level != 0
        if level.nil?
          holder += ele.my_flatten
        else
          holder += ele.my_flatten(level-1)
        end
      else
        holder << ele
      end
    end
    holder
  end
end

class String
  # Write a `String#symmetric_substrings` method that returns all substrings
  # that are equal to their reverse image ("abba" == "abba"). You should only
  # include substrings of length > 1.

  def symmetric_substrings
    new_arr = []

    self.each_char.with_index do |char1, i1|
      self.each_char.with_index do |char2, i2|
        if i1 < i2 && char1 == char2
          new_arr << self[i1..i2] if self[i1..i2] == self[i1..i2].reverse
        end
      end
    end
    new_arr
  end
end


# Write a method `nth_prime` that returns the nth prime number. You may wish to
# use an `is_prime?` helper method.

def nth_prime(n)
  return 2 if n == 1
  return nil if n == 0
  new_arr = []

  i = 2
  until new_arr.length == n 
    new_arr << i if (2...i).none? {|fac| i % fac == 0}
    i += 1
  end
  new_arr[-1]
end

def is_prime?(num)

end

class Array
  # Write an `Array#my_each` method that calls a passed block for each element
  # of the array. 
  # **Do NOT use the built-in `Array#each`, `Array#each_with_index`, or 
  # `Array#map` methods in your implementation.**

  def my_each(&prc)
    i = 0
    
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end
end

class Array
  # Write an `Array#my_select` method that returns an array made up of the
  # elements in the array that return `true` from the given block.
  # **Do NOT use the built-in `Array#select` or `Array#reject` methods in your
  # implementation.**

  def my_select(&prc)
    new_arr = []

    self.each do |ele|
      new_arr << ele if prc.call(ele)
    end
    new_arr
  end
end