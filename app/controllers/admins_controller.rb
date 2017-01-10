class AdminsController < Admins::BaseController

  def show
    @admin = current_admin

  end
end
