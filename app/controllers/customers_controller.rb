class CustomersController < Customer::BaseController

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.create(customer_params)
    flash[:success] = 'Successfully logged in!'
    redirect_to customer_path(@customer)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end
end
