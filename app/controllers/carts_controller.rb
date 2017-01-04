class CartsController < ApplicationController

  def create
    require 'pry'; binding.pry
    redirect_to items_path
  end

  def show
    byebug
  end
end
