class HomeController < ApplicationController
	def index
		@person = Person.all
		@posts = Post.all.order(updated_at: :desc).page(1).per 10
		@groups = Group.all
	end
end