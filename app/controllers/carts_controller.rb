class CartsController < ApplicationController
  include MessageHelper
  include ApplicationHelper

  def create
    add_item_to_cart
    set_cart_session
    flash_message_add_item_to_cart(item)
    redirect_to items_path
  end

  def show; end

  def destroy
    if params[:remove].nil?
      @cart.decrease_item_quantity(item.id)
      last_item
    else
      @cart.delete_entire_item(item.id)
      flash_message_remove_from_cart(item)
    end
    set_cart_session
    redirect_to cart_path
  end

  def last_item
    contents = @cart.contents[item.id]
    flash_message_remove_from_cart(item) if contents.nil?
  end

  def update
    add_item_to_cart
    redirect_to cart_path
  end

  private

  def set_cart_session
    session[:cart] = @cart.contents
  end

  def add_item_to_cart
    @cart.add_item(item.id)
  end

end
