class Admins::BaseController < ApplicationController
  before_action :require_admin
end
