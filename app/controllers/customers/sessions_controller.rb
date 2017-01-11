class Customers::SessionsController < Customers::BaseController
  include MessageHelper

  skip_before_action :require_customer

  def new; end

  def create
    if authenticated_customer?
      set_customer_session
      flash_message_successful_login
      redirect_to dashboard_path
    else
      flash_message_failed_login
      render :new
    end
  end

  def destroy
    reset_session
    flash_message_successful_logout
    redirect_to(login_path)
  end

  private

  def customer
    Customer.find_by(email: params[:email])
  end

  def set_customer_session
    session[:customer_id] = customer.id
    session[:admin_id] = nil
  end

  def authenticated_customer?
    customer && customer.authenticate(params[:password])
  end
end
