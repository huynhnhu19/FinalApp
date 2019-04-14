class HomeController < ApplicationController
	def index
		@person = Person.all
		@posts = Post.all
	end
end