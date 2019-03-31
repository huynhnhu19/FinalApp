class PostsController < ApplicationController
	def index
		@posts = current_person.posts.all
	end

	def show
		@post = Post.find(params[:id])
		@comment = @post.comments.new
		@reply = @comment.replies.new
	end

	def new
		@post = current_person.posts.new
	end

	def create
		@post = Post.create!(post_params)
		current_person.posts.create(@post)
		redirect_to person_posts_path(current_person)		
	end

	private
	def post_params
		params.require(:post).permit(:title, :content)
	end

end
