class Admins::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
  end

  def update
    order = Order.find(params["order_id"])
    order.status = Status.find_by(name: params["status"])
    order.save
    redirect_to admin_dashboard_path
  end

end
