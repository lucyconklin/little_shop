class Customers::OrdersController < Customers::BaseController
  before_action :set_orders

  def set_orders
    @orders = current_customer.orders
  end

  def index
  end

  def show
    @order = Order.find(params[:order_id])
    if @orders.include?(@order)
      render :show
    else
      render file: "/public/404"
    end
  end

end
