class CartsController < ApplicationController

  def create
    add_item_to_cart
    set_cart_session
    flash_add_message
    redirect_to items_path
  end

  def show
    @items = @cart.items
    @customer = current_customer?
  end

  def destroy
    if params[:remove].nil?
      @cart.decrease_item_quantity(item.id)
      last_item
    else
      @cart.delete_entire_item(item.id)
      flash_remove_message
    end
    set_cart_session
    redirect_to cart_path
  end

  def last_item
    item = @cart.contents[params[:item_id]]
    flash_remove_message if item.nil?
  end

  def flash_remove_message
    message = "Succesfully removed #{view_context.link_to(item.title, item)} from your cart."
    flash[:success] = message
  end

  def flash_add_message
    message = "You have added 1 #{item.title} to your cart."
    flash[:success] = message
  end

  def update
    add_item_to_cart
    redirect_to cart_path
  end

  private

  def item
    Item.find(params[:item_id])
  end

  def set_cart_session
    session[:cart] = @cart.contents
  end

  def add_item_to_cart
    @cart.add_item(item.id)
  end

end
