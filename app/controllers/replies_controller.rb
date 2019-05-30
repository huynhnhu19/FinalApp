class RepliesController < ApplicationController
	def create
		@comment = Comment.find(params[:comment_id])
		@reply = Reply.create!(params_reply)
		@comment.replies << @reply
		current_person.replies << @reply
		@new_reply = @comment.replies.new
	    respond_to do |format|
    	  format.html
      	  format.js
    	end
	end

	private

	def params_reply
		params.require(:reply).permit(:content)
	end
end
