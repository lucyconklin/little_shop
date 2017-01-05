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
      item_1 = create(:item, price_in_cents: 1010)
      item_2 = create(:item, price_in_cents: 1020)
      item_3 = create(:item, price_in_cents: 1030)
      cart = Cart.new({item_2.id => 1})

      cart.add_item(item_1.id)
      cart.add_item(item_2.id)
      cart.add_item(item_3.id)

      expect(cart.total_price_in_dollars).to eq(40.80)
    end
  end

  describe "#items" do
    it "returns all the items in the cart" do
      item_1, item_2, item_3 = create_list(:item, 3)
      cart = Cart.new({})
      cart.add_item(item_1.id)
      cart.add_item(item_2.id)
      cart.add_item(item_3.id)

      expect(cart.items).to match_array [item_1, item_2, item_3]
    end
  end

  describe "#items_with_quantities" do
    it "returns the items and their quantities" do
      item_1, item_2, item_3 = create_list(:item, 3)
      cart = Cart.new({})
      cart.add_item(item_1.id)
      cart.add_item(item_2.id)
      cart.add_item(item_2.id)
      cart.add_item(item_3.id)

      expect(cart.items_with_quantities).to eq({item_1 => 1,
                                                item_2 => 2,
                                                item_3 => 1})
    end
  end

  describe "#empty?" do
    it "returns true if nothing in cart" do
      cart = Cart.new({})

      expect(cart.empty?).to be true
    end

    it "returns false when there is something in cart" do
      item = create(:item)
      cart = Cart.new({})
      cart.add_item(item.id)

      expect(cart.empty?).to be false
    end
  end

  describe "#remove_item" do
    it "removes item from the cart" do
      item_1, item_2 = create_list(:item, 2)
      cart = Cart.new({ item_1.id.to_s => 2, item_2.id.to_s => 1 })

      cart.remove_item(item_1.id)
      expect(cart.contents).to eq({ item_1.id.to_s => 1, item_2.id.to_s => 1 })
    end

    it "removes item from cart entirely when quantity is 0" do
      item_1, item_2 = create_list(:item, 2)
      cart = Cart.new({ item_1.id.to_s => 1, item_2.id.to_s => 1 })

      cart.remove_item(item_1.id)
      expect(cart.contents).to eq({ item_2.id.to_s => 1 })
    end
  end
end
