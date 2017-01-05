class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def number_of_items
    contents.values.sum
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def price_and_quantity
    found_items = []
    contents.each_pair do |id,quantity|
      found_items <<[ Item.find(id).price_in_cents, quantity ]
    end
    found_items
  end

  def items
    Item.find(contents.keys)
  end

  def items_with_quantities
    item_quantity = {}
    contents.map do |id, quantity|
      item_quantity[Item.find(id)] = quantity
    end
    item_quantity
  end

  def total_price_in_cents
    price_and_quantity.reduce(0) do |memo,prices|
      memo += prices[0] * prices[1]
      memo
    end
  end

  def total_price_in_dollars
    total_price_in_cents / 100.to_f
  end
end
