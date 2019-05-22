require "application_responder"

class ApplicationController < ActionController::Base
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
end
