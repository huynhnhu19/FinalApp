class CommentsController < ApplicationController
  before_action :get_comment, :get_post
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
    @group = @post.belong_to
    if @group && @group.muted_members.include?(current_person)
      @message = "You have been MUTED in this group!"
      respond_to do |format|
        format.html
        format.js {render "home/alert"}
      end
    else
  		@comment = Comment.create!(params_comment)
  		@post.comments << @comment
  		current_person.comments << @comment
      @comment.add_upvote(current_person)
      @new_reply = Comment.new
      @list_post_comments = @post.comments.where(type: :comment)
      respond_to do |format|
        format.html
        format.js
      end
    end
	end

  def vote
    return unless params[:vote]
    if @comment.upvote.include?(current_person) || @comment.downvote.include?(current_person)
      if @comment.upvote.include?(current_person) && params[:vote] == "downvote"
          # post
          @comment.upvotes -= 1
          @comment.upvote.delete(current_person)
          @comment.downvotes += 1
          @comment.downvote << current_person
          @color = 'purple'
          # person
          current_person.upvote_comment.delete(@comment)
          current_person.downvote_comment << @comment
        elsif @comment.downvote.include?(current_person) && params[:vote] == "upvote"
          @comment.downvotes -= 1
          @comment.downvote.delete(current_person)
          @comment.upvotes += 1
          @comment.upvote << current_person
          # person
          current_person.upvote_comment << @comment
          current_person.downvote_comment.delete(@comment)
          @color = "red"
        elsif @comment.upvote.include?(current_person) && params[:vote] == "upvote"
          @comment.upvotes -= 1
          @comment.upvote.delete(current_person)
          current_person.upvote_comment.delete(@comment)
          @color = "none"
        else
          @comment.downvotes -= 1
          @comment.downvote.delete(current_person)
          current_person.downvote_comment.delete(@comment)
          @color = "none"
      end
    else
      if params[:vote] == "upvote"
        @comment.upvotes += 1
        @comment.upvote << current_person
        current_person.upvote_comment << @comment
        @color = "red"
      else
        @comment.downvotes += 1
        @comment.downvote << current_person
        current_person.downvote_comment << @comment
        @color = 'purple'
      end
    end
    @comment.save!
    current_person.save!
    respond_to do |format|
      format.html
      format.js
    end
  end

  def reply
    @comment = Comment.create!(params_comment.merge(type: :reply))
    @parent_comment = Comment.find(params[:comment_id])
    @parent_comment.replies << @comment
    current_person.comments << @comment
    @comment.add_upvote(current_person)
    @comment.post = @post
    @new_reply = Comment.new
    respond_to do |format|
      format.html
      format.js {render :replies}
    end
  end

  def report
    
  end
	private

  def get_post
    return unless params[:post_id]
    @post = Post.find(params[:post_id])
  end

  def get_comment
    @comment = Comment.find_by(id: params[:id])
  end

	def params_comment
		params.require(:comment).permit(:content)
	end
end
