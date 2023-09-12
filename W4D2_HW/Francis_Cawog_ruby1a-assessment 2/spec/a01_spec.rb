require 'rspec'
require 'spec_helper'
require 'a01'

describe "Array#merge_sort" do
  let(:array1) { [4, 2, 3, 1, 5] }
  let(:array2) { [6, 9, 8, 10, 7] }
  let(:array3) { [*0..100].shuffle }

  before(:each) do
    expect_any_instance_of(Array).not_to receive(:sort)
    expect_any_instance_of(Array).not_to receive(:sort!)
    expect_any_instance_of(Array).not_to receive(:sort_by!)
  end

  it "works with an empty array" do
    expect([].merge_sort).to eq([])
  end

  it "works with an array of one item" do
    expect([1].merge_sort).to eq([1])
  end

  it "sorts numbers" do
    expect(array1.merge_sort).to eq([1, 2, 3, 4, 5])
    expect(array2.merge_sort).to eq([6, 7, 8, 9, 10])
    val = array3.shift
    expect(array3.merge_sort).to eq([*0..100] - [val])
  end

  it "sorts arrays with duplicates" do
    expect([5, 4, 3, 3, 2, 1].merge_sort).to eq([1, 2, 3, 3, 4, 5])
    expect([5, 3, 1, 5, 2, 7].merge_sort).to eq([1, 2, 3, 5, 5, 7])
  end

  it "will use block if given" do
    reversed = array1.merge_sort do |num1, num2|
      # reverse order
      num2 <=> num1
    end
    expect(reversed).to eq([5, 4, 3, 2, 1])

    val = array3.shift
    reversed = array3.merge_sort do |num1, num2|
      # reverse order
      num2 <=> num1
    end
    expect(reversed).to eq([*0..100].reverse - [val])
  end

  it "does not modify original" do
    duped_array = array1.dup
    duped_array.merge_sort
    expect(duped_array).to eq(array1)
  end

  it "calls the merge helper method" do
    expect(Array).to receive(:merge).at_least(:once).and_call_original
    array1.merge_sort
  end
end

describe "Array#pair_sum" do
  it "returns positions of pairs of numbers that add to zero" do
    expect([5, 1, -7, -5].pair_sum(0)).to eq([[0, 3]])
  end

  it "returns positions of pairs that add to other targets" do
    expect([2, 1, 4, -2].pair_sum(5)).to eq([[1, 2]])
  end

  it "finds multiple pairs" do
    expect([5, -1, -5, 1].pair_sum(0)).to eq([[0, 2], [1, 3]])
  end

  it "finds pairs with same element" do
    expect([5, -5, -5].pair_sum(0)).to eq([[0, 1], [0, 2]])
  end

  it "returns [] when no pair is found" do
    expect([5, 5, 3, 1].pair_sum(7)).to eq([])
  end

  it "won't find spurious target pairs" do
    expect([0, 1, 2, 3].pair_sum(0)).to eq([])
  end
end

describe "Array#my_flatten" do
  let(:array) { ["a", "b", ["c", "d", ["e"]]] }

  before(:each) do
    expect_any_instance_of(Array).not_to receive(:flatten)
    expect_any_instance_of(Array).not_to receive(:flatten!)
  end

  it "does not modify the original array" do
    array.my_flatten

    expect(array).to eq(["a", "b", ["c", "d", ["e"]]])
  end

  context "when called with no level specified" do
    it "recursively flattens all nested arrays" do
      expect(array.my_flatten).to eq(["a", "b", "c", "d", "e"])
    end
  end

  context "when called with level = 0" do
    it "does not flatten the array" do
      expect(array.my_flatten(0)).to eq(["a", "b", ["c", "d", ["e"]]])
    end
  end

  context "when called with level = 1" do
    it "flattens arrays nested one level deep" do
      expect(array.my_flatten(1)).to eq(["a", "b", "c", "d", ["e"]])
    end
  end
end

describe "String#symmetric_substrings" do
  it "handles a simple example" do
    expect("aba".symmetric_substrings).to match_array(["aba"])
  end

  it "handles two substrings" do
    expect("aba1cdc".symmetric_substrings).to match_array(["aba", "cdc"])
  end

  it "handles nested substrings" do
    expect("xabax".symmetric_substrings).to match_array(["aba", "xabax"])
  end
end

describe "#nth_prime" do
  it "returns the first prime number" do
    expect(nth_prime(1)).to eq(2)
  end

  it "returns the fifth prime number" do
    expect(nth_prime(5)).to eq(11)
  end

  it "returns nil when asked for the zeroth prime" do
    expect(nth_prime(0)).to be_nil
  end
end

describe 'Array#my_each' do
  let(:arr) { [1,2,3] }
  
  before(:each) do
    expect(arr).not_to receive(:each)
    expect(arr).not_to receive(:each_with_index)
    expect(arr).not_to receive(:map)
    expect(arr).not_to receive(:map!)
    expect(arr).not_to receive(:dup)
    expect(arr).not_to receive(:slice)
    expect(arr).not_to receive(:slice!)
    expect_any_instance_of(Range).not_to receive(:each)
    arr.my_each { |el| el }
  end
  
  it 'calls the block passed to it' do
    expect do |block|
      ["test array"].my_each(&block)
    end.to yield_control.once
  end

  it 'yields each element to the block' do
    expect do |block|
      ["el1", "el2"].my_each(&block)
    end.to yield_successive_args("el1", "el2")
  end

  it 'is chainable and returns the original array' do
    original_array = ["original array"]
    expect(original_array.my_each {}).to be(original_array)
  end
end

describe 'Array#my_select' do
  let(:arr) { [1,2,3] }
  before(:each) do
    expect(arr).not_to receive(:select)
    expect(arr).not_to receive(:dup)
    expect_any_instance_of(Array).not_to receive(:select!)
    expect_any_instance_of(Array).not_to receive(:reject)
    expect_any_instance_of(Array).not_to receive(:reject!)
    arr.my_select { |el| el }
  end

  it 'calls the block passed to it' do
    expect do |block|
      ["test element"].my_select(&block)
    end.to yield_control
  end

  it 'yields each element to the block' do
    test_array = ["el1", "el2", "el3"]
    expect do |block|
      test_array.my_select(&block)
    end.to yield_successive_args("el1", "el2", "el3")
  end

  it 'returns an array of filtered down items' do
    test_array = [1, 2, 3, 4, 5]
    expect(test_array.my_select(&:odd?)).to eq([1, 3, 5])
    expect(test_array.my_select { |el| el < 3 }).to eq([1, 2])
  end
end

