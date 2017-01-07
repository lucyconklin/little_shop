class Customers::SessionsController < Customers::BaseController
  skip_before_action :require_customer, :only => [:new, :create]

  def new
    # render 'customers/sessions/new'
  end

  def create
    @customer = Customer.find_by(email: params[:email])
    if @customer && @customer.authenticate(params[:password])
      session[:customer_id] = @customer.id
      flash[:success] = "Successfully logged in!"
      redirect_to customer_path(@customer)
    else
      flash[:danger] = "Email and password combination do not exist"
      render :new
    end
  end
end
