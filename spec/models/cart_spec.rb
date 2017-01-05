require 'rails_helper'

describe Cart do
  # it 'the cart be able to contain items' do
  #   cart = Cart.new
  #   cart.contents =  create_list(:item, 5)
  #
  #   expect(cart.contents.count).to eq(5)
  # end

  describe "#number_of_items" do
    it "returns the total number of items in the cart" do
      cart = Cart.new({"1" => 2, "3" => 5})

      expect(cart.number_of_items).to eq 7
    end
  end

  describe "#add_item" do
    it "increases the quantity of that item in the cart by 1" do
      cart = Cart.new({"2" => 1})
      cart.add_item(1)
      cart.add_item(2)
      cart.add_item(5)

      expect(cart.contents).to eq({"1" => 1, "2" => 2, "5" => 1})
    end
  end
end
