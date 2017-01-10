class Admins::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:order_id])
  end

  def update
    order = Order.find(params["order_id"])
    order.status = Status.find_by(name: params["status"])
    order.save
    redirect_to admin_dashboard_path
    # if Status.all.include?(params[:status])
    # order.save
  end

end
