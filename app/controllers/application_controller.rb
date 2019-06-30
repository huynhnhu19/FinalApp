require "application_responder"

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  self.responder = ApplicationResponder
  respond_to :html

	# before_action :authenticate_person!
  def index
    @groups = Group.all
  end

  def after_sign_out_path_for(resource_or_scope)
    if current_person
      request.referrer
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
