class CategoriesController < ApplicationController

  def show
    @category = Category.friendly.find(params[:id])
    @items = @category.items
  end
end
