class OrderProcessor
  include ApplicationHelper

  def self.process(customer, cart_items)
    order = Order.new(status: status("ordered"))
    order.items = cart_items
    order.customer = customer
    order.save
  end
end
