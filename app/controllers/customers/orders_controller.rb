class Customers::OrdersController < Customers::BaseController
  before_action :customer_orders
  include ApplicationHelper

  def customer_orders
    current_customer.orders
  end

  def index
    @status_filter = params[:status_filter]
    @statuses = Status.all.sort_by_name

    if valid_status_filter?
      @orders = filter_orders
    else
      render file: "/public/404"
    end
  end

  def show
    @order = order
    if customer_orders.include?(@order)
      render :show
    else
      render file: "/public/404"
    end
  end

  private

  def valid_status_filter?
    status_names = @statuses.pluck(:name)
    @status_filter.nil? || status_names.include?(@status_filter)
  end

  def filter_orders
    if @status_filter.nil?
      @orders = customer_orders.most_recent
    else
      status = status(@status_filter)
      @orders = customer_orders.where(status: status).most_recent
    end
  end

end
