class RepliesController < ApplicationController
	def create
		@comment = Comment.find(params[:comment_id])
		@reply = Reply.create!(params_reply)
		@comment.replies << @reply
		current_person.replies << @reply
		redirect_to person_posts_path(current_person)
	end

	private

	def params_reply
		params.require(:reply).permit(:content)
	end
end
