class Admins::SessionsController < Admins::BaseController
  skip_before_action :require_admin

  def new; end

  def create
    if admin && admin.authenticate(params[:password])
      set_admin_session
      flash_message_successful_login
      redirect_to admin_dashboard_path
    else
      flash_message_failed_login
      render :new
    end
  end

  def destroy
    reset_session
    flash_message_successful_logout
    redirect_to admin_login_path
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :password)
  end

  def admin
    Admin.find_by(email: params[:email])
  end

  def set_admin_session
    session[:admin_id] = admin.id
    session[:customer_id] = nil
  end
end
