class AdminsController < Admins::BaseController
  include MessageHelper
  def show
    @admin = current_admin
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
