class Admins::BaseController < ApplicationController
  before_action :require_admin

  private
  
  def require_admin
    unless current_admin?
      render file: "/public/404"
    end
  end
end
