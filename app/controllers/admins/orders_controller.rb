class Admins::OrdersController < ApplicationController

  def show
    @order = order(params[:id])
  end

  def update
    order = order(params["order_id"])
    order.status = status
    order.save
    redirect_to admin_dashboard_path
  end

end
