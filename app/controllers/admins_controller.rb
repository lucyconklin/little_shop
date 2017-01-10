class AdminsController < Admins::BaseController
  include MessageHelper
  def show
    @admin = current_admin # take this line out
    # @status_name = Order.group(:status).count(:id)

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

  def edit
    @admin = current_admin
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      flash_message_success
      redirect_to admin_dashboard_path
    else
      render :edit
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :email, :password)
  end
end
