class CustomersController < Customers::BaseController
  skip_before_action :require_customer, only: [:new, :create]

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      session[:customer_id] = @customer.id
      flash[:success] = 'Successfully logged in!'
      #redirect_to dashboard_path
      redirect_to_correct_path
    else
      @errors = @customer.errors
      render :new
    end
  end

  def redirect_to_correct_path
    if @cart.contents.empty?
      redirect_to dashboard_path
    else
      redirect_to cart_path
    end
  end

  def dashboard
    @customer = current_customer
  end

  private

  def customer_params
    params.require(:customer).permit( :first_name,
      :last_name,
      :email,
      :password,
    :password_confirmation)
  end
end
