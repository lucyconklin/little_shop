class CheckoutController < ApplicationController
  include MessageHelper

  def checkout
    OrderProcessor.new.process(current_customer, @cart.items)
    clear_cart
    flash_message_successful_order
    redirect_to customer_orders_path
  end
end
