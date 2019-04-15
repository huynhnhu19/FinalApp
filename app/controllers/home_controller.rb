class HomeController < ApplicationController
	def index
		@person = Person.all
		@posts = Post.all.order(updated_at: :desc)
	end
end