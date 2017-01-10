class Customers::OrdersController < Customers::BaseController
  before_action :customer_orders

  def customer_orders
    current_customer.orders
  end

  def index
    @status_filter = params[:status_filter]
    @statuses = Status.all

    if @status_filter.nil?
      @orders = customer_orders.most_recent
    elsif @statuses.pluck(:name).include?(@status_filter) == false
      render file: "/public/404"
    else
      status = Status.find_by(name: @status_filter)
      @orders = customer_orders.where(status: status).most_recent
    end
  end

  def show
    @order = Order.find(params[:order_id])
    if customer_orders.include?(@order)
      render :show
    else
      render file: "/public/404"
    end
  end

end
