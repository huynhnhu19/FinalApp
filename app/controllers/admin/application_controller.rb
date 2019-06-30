class Admin::ApplicationController < ActionController::Base
  layout "admin"
  before_action :authenticate_admin!
  protect_from_forgery
end
