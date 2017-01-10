class Admin::OrdersController < ApplicationController

  def index
    @status_filter = params[:status_filter]
    @statuses = Status.all

    if @status_filter.nil?
      @orders = Order.all
    elsif @statuses.pluck(:name).include?(@status_filter) == false
      render file: "/public/404"
    else
      status = Status.find_by(name: @status_filter)
      @orders = status.orders.most_recent
    end
  end

  def show
    @order = Order.find(params[:order_id])
  end

end
