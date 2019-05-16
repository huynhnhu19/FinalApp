class CommentsController < ApplicationController
	def index
		@post = Post.find(params[:post_id])
		@comment = @post.comments.all
	end

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
    @reply = @comment.replies.new


    respond_to do |format|
      format.html
      format.js
    end

	end

	private

	def params_comment
		params.require(:comment).permit(:content)
	end
end
