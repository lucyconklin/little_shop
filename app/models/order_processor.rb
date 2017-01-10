class OrderProcessor
  attr_accessor :order

  def initialize
    @order = Order.new(status: Status.find_by(name: "ordered"))
  end

  def process(customer, cart_items)
    set_items(cart_items)
    set_customer(customer)
    order.save
  end

  private

    def set_items(cart_items)
      order.items = cart_items
    end

    def set_customer(customer)
      order.customer = customer
    end
end
