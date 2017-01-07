module ModelHelpers

  def add_one_item_to_cart
    cart = Cart.new({})
    item_1 = create(:item, id: 1, price_in_cents: 1010)
    cart.add_item(item_1.id)
    cart
  end

  def add_three_items_to_cart
    cart = Cart.new({})
    item_1 = create(:item, id: 1, price_in_cents: 1010)
    item_2 = create(:item, id: 2, price_in_cents: 1020)
    item_3 = create(:item, id: 3, price_in_cents: 1030)

    cart.add_item(item_1.id)
    cart.add_item(item_2.id)
    cart.add_item(item_3.id)
    cart
  end

end
