require'rails_helper'

describe Cart do

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
  describe "#total_price_in_dollars" do
    it 'sums the price of all the items in the cart' do
      num = 1000
      item_1 = create(:item, price_in_cents: num += 10)
      item_2 = create(:item, price_in_cents: num += 10)
      item_3 = create(:item, price_in_cents: num += 10)
      cart = Cart.new({item_2.id => 1})

      cart.add_item(item_1.id)
      cart.add_item(item_2.id)
      cart.add_item(item_3.id)

      expect(cart.total_price_in_dollars).to eq(40.80)
    end
  end
end
