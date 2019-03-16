class PostController < ApplicationController
	def new
		@person = current_person
		@post = @person.posts.new
	end

	def create
		@person = current_person
		@post = @person.posts.build(post_params)
		@post.save
		redirect_to current_person
	end

	def edit
		@person = current_person
		@post = Post.find(params[:id])
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
	end

	private
	def post_params
		params.require(:post).permit(:title, :decription)
	end

	def post_update_params
		params.require(:post).permit(:title, :description)
	end

end