class HomeController < ApplicationController
	def index
		@person = Person.all
		@groups = Group.all
		@posts = Post.all.where(post_creation: false)
    if current_person
      @hidden_post = current_person.posts_hidden
      @posts = @posts.to_a - @hidden_post.to_a
    end
		@posts = @posts.sort { |x, y | y.created_at <=> x.created_at } if params[:order_sort] == 'new'
		@posts = @posts.sort { |x, y | y.upvotes <=> x.upvotes } if params[:order_sort] == 'hot'
		@posts = @posts.order(controversial: :desc) if params[:order_sort] == 'controversial'

		respond_to do |format|
  		format.html
  		format.js
    end
	end
end