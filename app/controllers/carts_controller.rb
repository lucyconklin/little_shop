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
    byebug
    item = Item.find(params[:item_id])
    @cart.remove_item(item.id)
    session[:cart] = @cart.contents
    path = request.env['PATH_INFO']
    unless path.eql?("/cart")
      flash[:success] = "Succesfully removed #{view_context.link_to(item.title, item)} from your cart."
    end
    redirect_to cart_path
  end

  def update
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    redirect_to cart_path
  end
end
