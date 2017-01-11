class OrderProcessor
  include ApplicationHelper

  attr_reader :order

  def initialize
    @order = Order.new(status: status("ordered"))
  end

  def process(customer, cart_items)
    order.items = cart_items
    order.customer = customer
    order.save
  end
end
