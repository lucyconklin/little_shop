class Admins::ItemsController < Admins::BaseController
  include MessageHelper

  def index
    @items = Item.all
  end

  def edit
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

  private

  def item
    Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :description, :image_url, :retired)
  end

end
