class CheckoutsController < Customers::BaseController
  include MessageHelper
  before_action :checkout, only: [:new]

  def new
  end

  def create
    customer = current_customer.stripe_customer

    begin
      token = params[:stripeToken]
      current_customer.assign_attributes(
        card_brand: params[:card_brand],
        card_last4: params[:last4],
        card_exp_month: params[:card_exp_month],
        card_exp_year: params[:card_exp_year]
      ) if params[:card_last4]
      current_customer.save

      flash.notice = "Thank you for your payment"
      redirect_to customer_orders_path
      charge = Stripe::Charge.create(
                  :amount => @cart.total_price_in_cents,
                  :currency => "usd",
                  :description => "#{@cart.items.first.title}...",
                  :source => token,
                 )
    rescue Stripe::CardError => e
      flash.alert = e.message
      render action: :new
    end
    clear_cart
    flash_message_successful_order
  end

  def checkout
    OrderProcessor.new.process(current_customer, @cart.items)
  end
end
