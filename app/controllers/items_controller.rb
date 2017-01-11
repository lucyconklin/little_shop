class ItemsController < ApplicationController
  include MessageHelper
  include ApplicationHelper

  def index
    @items = Item.all
  end

  def show
    @item = item(params[:id])
  end

end
