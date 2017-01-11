class ApplicationController < ActionController::Base
  include ApplicationHelper
  include MessageHelper

  protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :current_customer?
  helper_method :current_customer
  helper_method :current_admin?
  helper_method :current_admin

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def clear_cart
    session[:cart] = nil
  end

  private

  def current_customer?
    !!current_customer
  end

  def current_customer
    @current_customer ||= customer if session[:customer_id]
  end


  def current_admin?
    !!current_admin
  end

  def current_admin
    @current_admin ||= admin(session[:admin_id]) if session[:admin_id]
  end
end
