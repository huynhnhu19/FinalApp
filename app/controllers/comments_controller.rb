class CommentsController < ApplicationController
	def new
		@post = Post.find(params[:id])
		@comment = @post.comments.new
	end
	def create
		@post = Post.find(params[:post_id])
		@comment = Comment.create!(params_comment)
		@post.comments << @comment
		@post.save!
		current_person.comments << @comment
		current_person.save!
		redirect_to person_posts_path(current_person)
	end

	private

	def params_comment
		params.require(:comment).permit(:content)
	end
end
