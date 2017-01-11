class OrderProcessor
  attr_accessor :order

  def initialize
    @order = Order.new(status: Status.find_by(name: "ordered"))
  end

  def process(customer, cart_items)
    order.items = cart_items
    order.customer = customer
    order.save
  end
end
