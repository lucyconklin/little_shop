class CheckoutController < ApplicationController
  include MessageHelper

  def checkout
    order = Order.new(customer: current_customer,
                      status: Status.find_by(name: "ordered"))
    order.items = @cart.items
    order.save
    session[:cart] = nil
    flash_message_successful_order

    redirect_to customer_orders_path
  end
end
