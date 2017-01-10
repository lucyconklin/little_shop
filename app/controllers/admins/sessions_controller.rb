class Admins::SessionsController < Admins::BaseController
  include MessageHelper
  def new
  end

  def create
    admin = Admin.find_by(email: params[:email])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      session[:customer_id] = nil
      flash_message_successful_login
      redirect_to admin_dashboard_path
    else
      flash_message_failed_login
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    flash_message_successful_logout
    redirect_to admin_login_path
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :password)
  end
end
