class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = item(params[:id])
  end
end
