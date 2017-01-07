class Customer::SessionsController < Customer::BaseController
  def new
  end

  def create
    @customer = Customer.find_by(email: params[:email])
    if @customer.authenticate(params[:password])
      session[:customer_id] = @customer.id
      flash[:success] = "Successfully logged in!"
      redirect_to customer_path(@customer)
    else
      render :new
    end
  end
end
