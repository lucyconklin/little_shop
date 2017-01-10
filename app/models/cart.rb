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
    contents.map do |id, quantity|
      [find_item(id).price_in_cents, quantity]
    end
  end

  def items
    items_with_quantities.reduce(Array.new) do |collector, (item, quantity)|
      quantity.times { collector << item }
      collector
    end
  end

  def find_item(id)
    Item.find(id)
  end

  def items_with_quantities
    contents.reduce({}) do |memo, (id, quantity)|
      memo[find_item(id)] = quantity
      memo
    end
  end

  def total_price_in_cents
    price_and_quantity.reduce(0) do |memo, prices|
      memo += prices[0] * prices[1]
      memo
    end
  end

  def total_price_in_dollars
    total_price_in_cents / 100.to_f
  end

  def empty?
    contents.empty?
  end

  def decrease_item_quantity(item_id)
    contents[item_id.to_s] -= 1
    clean_cart
  end

  def delete_entire_item(item_id)
    contents.delete(item_id.to_s)
  end

  private

  def clean_cart
    contents.delete_if do |item_id, quantity|
      quantity == 0
    end
  end
end
