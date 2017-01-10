class AdminsController < Admins::BaseController
  include MessageHelper
  def show
    @admin = current_admin # take this line out
    @filter_by = params[:filter_by] # this is the only thing we are taking out of the params
    @statuses = Status.all # dashboard.statuses
    @status_name = Order.group(:status).count(:id) #dashboard.status_names
    # make an AdminDashboard model for these new methods to live in

    if @filter_by.nil?
      @orders = Order.all
    elsif @statuses.pluck(:name).include?(@filter_by) == false
      render file: "/public/404"
    else
      @orders = Order.where(status: Status.find_by(name: @filter_by))
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
