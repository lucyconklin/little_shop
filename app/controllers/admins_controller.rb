class AdminsController < Admins::BaseController
  before_action :require_admin

  def show
    @status_filter = status_filter
    @statuses = Status.all.sort_by_name
    if valid_status_filter?
      @orders = filter_orders
    else
      render file: "/public/404"
    end
  end

  def edit; end

  def update
    if admin.update(admin_params)
      flash_message_success
      redirect_to admin_dashboard_path
    else
      render :edit
    end
  end

  private

  def status_filter
    params[:status_filter]
  end

  def valid_status_filter?
    status_names = @statuses.pluck(:name)
    status_filter.nil? || status_names.include?(status_filter)
  end

  def filter_orders
    if status_filter.nil?
      Order.all.most_recent
    else
      status = status(status_filter)
      status.orders.most_recent
    end
  end

  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :email, :password)
  end
end
