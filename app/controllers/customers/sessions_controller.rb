class Customers::SessionsController < Customers::BaseController
  include MessageHelper
  skip_before_action :require_customer, only: [:new, :create]

  def new; end

  def create
    @customer = Customer.find_by(email: params[:email])
    if @customer && @customer.authenticate(params[:password])
      session[:admin_id] = nil
      session[:customer_id] = @customer.id
      flash_message_successful_login
      redirect_to dashboard_path
    else
      flash_message_failed_login
      render :new
    end
  end

  def destroy
    session[:customer_id] = nil
    clear_cart
    flash_message_successful_logout
    redirect_to(login_path)
  end
end
