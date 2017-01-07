class Customer::BaseController < ApplicationController
  before_action :require_customer

  def require_customer
    render file: "/public/404" unless current_customer?
  end
end
