class FriendshipController < ApplicationController
	def index
		@person = Person.all
	end
end