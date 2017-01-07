class CustomersController < Customers::BaseController
  skip_before_action :require_customer, :only => [:new, :create]

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      session[:customer_id] = @customer.id
      flash[:success] = 'Successfully logged in!'

      redirect_to dashboard_path
    else
      @errors = @customer.errors
      render :new
    end
  end

  def dashboard
    @customer = @current_customer
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
