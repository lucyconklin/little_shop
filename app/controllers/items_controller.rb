class ItemsController < ApplicationController
  include MessageHelper
  before_action :require_admin_login, except: [:index, :show]

  def index
    @items = Item.all
  end

  def show
    @item = item
  end

  def edit
    byebug
    @item = item
  end

  def update
    @item = item
    if @item.update(item_params)
      flash_message_successful_update
      redirect_to item_path(item)
    else
      flash_message_failed_update
      render :edit
    end
  end

  def item
    Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :image_url, :retired)
  end
end
