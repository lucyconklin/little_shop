class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :current_customer?
  helper_method :current_customer
  helper_method :current_admin?
  helper_method :current_admin


  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_customer?
    !!current_customer
  end

  def current_customer
    @current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
  end

  def current_admin?
    !!current_admin
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

end
