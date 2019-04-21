class ApplicationController < ActionController::Base
	before_action :authenticate_person!
  def index
    @groups = Group.all
  end
end
