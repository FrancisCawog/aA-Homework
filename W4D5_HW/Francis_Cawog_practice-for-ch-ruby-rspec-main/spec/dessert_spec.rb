require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef"), name: "Francis"}
  let(:tres_leches) {Dessert.new("tres_leches", 350, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(tres_leches.type).to eq("tres_leches")
    end

    it "sets a quantity" do
      expect(tres_leches.quantity).to eq(350)
    end

    it "starts ingredients as an empty array" do
      expect(tres_leches.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("ice_cream", "pints", chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      tres_leches.add_ingredient("milk")
      expect(tres_leches.ingredients).to include("milk")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["milk", "flour", "eggs", "condensed_milk", "evaporated_milk"]

      ingredients.each do |ingredient|
        tres_leches.add_ingredient(ingredient)
      end

      expect(tres_leches.ingredients).to eq(ingredients)
      tres_leches.mix!
      expect(tres_leches.ingredients).not_to eq(ingredients)
      expect(tres_leches.ingredients.sort).to eq(ingredients.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      tres_leches.eat(16)
      expect(tres_leches.quantity).to eq(32)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { tres_leches.eat(100)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Francis the Great Baker")
      expect(tres_leches.serve).to eq("Chef Francis the Great Baker has made 350 tres_leches!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(tres_leches)
      tres_leches.make_more
    end
  end
end