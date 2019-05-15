class HomeController < ApplicationController
	def index
		@person = Person.all
		@groups = Group.all
		@posts = Post.all
    @hidden_post = current_person.posts_hidden
    @posts = @posts.to_a - @hidden_post.to_a
		@posts = @posts.order(created_at: :desc) if params[:order_sort] == 'new'
		@posts = @posts.order(upvotes: :desc) if params[:order_sort] == 'hot'
		@posts = @posts.order(controversial: :desc) if params[:order_sort] == 'controversial'

		respond_to do |format|
      		format.html
      		format.js
    	end
	end
end