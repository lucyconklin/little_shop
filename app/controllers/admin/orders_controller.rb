class Admin::OrdersController < ApplicationController

  def index
    @filter_by = params[:filter_by]
    @statuses = Status.all

    if @filter_by.nil?
      @orders = Order.all
    elsif @statuses.pluck(:name).include?(@filter_by) == false
      render file: "/public/404"
    else
      @orders = Order.where(status: Status.find_by(name: @filter_by))
    end
  end

  def show
    @order = Order.find(params[:order_id])
  end

end
