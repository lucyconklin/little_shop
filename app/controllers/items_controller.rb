class ItemsController < ApplicationController
  include MessageHelper

  def index
    @items = Item.all
  end

  def show
    @item = item
  end

  private

  def item
    Item.find(params[:id])
  end
end
