class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :current_customer?
  helper_method :current_customer

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_customer?
    !!current_customer
  end

  def current_customer
    @current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
  end

end
