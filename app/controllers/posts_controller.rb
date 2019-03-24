class PostsController < ApplicationController
  def new
  	@person = current_person
  	@post = current_person.posts.new
  end

  def create
  	@person = current_person
	@post = Post.create!(post_params)
	@person.posts.create(@post)
	redirect_to root_path

  end

  private
	def post_params
		params.require(:post).permit(:title, :content, :mode)
	end

end
