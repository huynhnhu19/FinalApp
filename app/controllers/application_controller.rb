class ApplicationController < ActionController::Base
	before_action :authenticate_person!
end
