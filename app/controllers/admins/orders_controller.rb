class Admins::OrdersController < ApplicationController
  include ApplicationHelper

  def show
    @order = order
  end

  def update
    order = order(params["order_id"])
    order.status = status
    order.save
    redirect_to admin_dashboard_path
  end

end
