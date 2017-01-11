class CheckoutsController < ApplicationController
  include MessageHelper
  before_action :checkout, only: [:new]

  def new

  end

  def checkout
    OrderProcessor.new.process(current_customer, @cart.items)
  end

  private

  def after
    clear_cart
    flash_message_successful_order
  end
end
