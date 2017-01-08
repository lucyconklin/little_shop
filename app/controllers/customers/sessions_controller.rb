class Customers::SessionsController < Customers::BaseController
  skip_before_action :require_customer, only: [:attempt_login, :login]

  def attempt_login
  end

  def login
    @customer = Customer.find_by(email: params[:email])
    if @customer && @customer.authenticate(params[:password])
      session[:customer_id] = @customer.id
      flash[:success] = "Successfully logged in"
      redirect_to dashboard_path
    else
      flash[:danger] = "Email and password combination do not exist"
      render :attempt_login
    end
  end

  def logout
    session[:customer_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to(login_path)
  end

end
