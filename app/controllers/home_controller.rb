class HomeController < ApplicationController
	def index
		@person = Person.all
		@groups = Group.all
		@posts = Post.all 
		@posts = @posts.order(created_at: :desc) if params[:order_sort] == 'new'
		@posts = @posts.order(upvotes: :desc) if params[:order_sort] == 'hot'
		@posts = @posts.order(controversial: :desc) if params[:order_sort] == 'controversial'
		
		respond_to do |format|
      		format.html
      		format.js
    	end
	end
end