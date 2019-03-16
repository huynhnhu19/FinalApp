class HomeController < ApplicationController
	def index
		@person = Person.all
		@post = Post.all
	end
end