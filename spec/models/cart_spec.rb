require'rails_helper'

describe Cart do
  let!(:cart) { add_three_items_to_cart }

  describe "#number_of_items" do
    it "returns the total number of items in the cart" do
      cart = Cart.new({"1" => 2, "3" => 5})

      expect(cart.number_of_items).to eq 7
    end
  end

  describe "#add_item" do
    it "increases the quantity of that item in the cart by 1" do
      cart.add_item(2)

      expect(cart.contents).to eq({"1" => 1, "2" => 2, "3" => 1})
    end
  end

  describe "#total_price_in_dollars" do
    it 'sums the price of all the items in the cart' do
      expect(cart.total_price_in_dollars).to eq(30.60)
    end
  end

  describe "#items" do
    let!(:item_1) { Item.find(1) }
    let!(:item_2) { Item.find(2) }
    let!(:item_3) { Item.find(3) }

    it "returns all the items in the cart" do
      expect(cart.items).to match_array [item_1, item_2, item_3]
    end
  end

  describe "#items_with_quantities" do
    let!(:item_1) { Item.find(1) }
    let!(:item_2) { Item.find(2) }
    let!(:item_3) { Item.find(3) }

    it "returns the items and their quantities" do
      cart.add_item(2)

      expect(cart.items_with_quantities).to include(item_1 => 1, item_2 => 2, item_3 => 1)
    end
  end

  describe "#empty?" do
    it "returns true if nothing in cart" do
      cart = Cart.new({})

      expect(cart.empty?).to be true
    end

    it "returns false when there is something in cart" do
      expect(cart.empty?).to be false
    end
  end

  describe "#decrease_item_quantity" do
    let!(:item_1) { Item.find(1) }
    let!(:item_2) { Item.find(2) }

    it "decreases item quantity from the cart" do
      expect(cart.contents).to include("1" => 1, "2" => 1)

      cart.decrease_item_quantity(1)

      expect(cart.contents).to include("2" => 1)
    end

    it "removes item from cart entirely when quantity is decreased to 0" do
      cart.decrease_item_quantity(item_1.id)

      expect(cart.contents).not_to have_key(item_1.id)
      expect(cart.contents).to include(item_2.id.to_s => 1)
    end
  end

  describe "#delete_item" do
    let!(:item_1) { Item.find(1) }
    let!(:item_2) { Item.find(2) }

    it 'deletes an item from the cart and leaves the remaining item' do
      cart.delete_entire_item(item_1.id)

      expect(cart.contents).not_to have_key(item_1.id)
      expect(cart.contents).to include(item_2.id.to_s => 1)
    end
  end
end
