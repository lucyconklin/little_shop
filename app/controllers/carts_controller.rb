class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:success] = "You have added 1 #{item.title} to your cart."
    redirect_to items_path
  end

  def show
    @items = @cart.items
  end

  def destroy
    if params[:remove].nil?
      item = Item.find(params[:item_id])
      @cart.remove_item(item.id)
      session[:cart] = @cart.contents
    else
      item = Item.find(params[:item_id])
      @cart.contents.delete(item.id.to_s)
      session[:cart] = @cart.contents
      flash[:success] = message(item)
    end
    redirect_to cart_path
  end

  def message(item)
    "Succesfully removed #{view_context.link_to(item.title, item)} from your cart."
  end

  def update
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    redirect_to cart_path
  end
end
