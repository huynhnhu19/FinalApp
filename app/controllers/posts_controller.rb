class PostsController < ApplicationController
	before_action :get_group, :get_post
	def index
		@posts = current_person.posts.all.order(updated_at: :asc).page(1).per 10
		# @post = Post.find(params[:id])
		# @time = Time.now.min - @post.created_at.min
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
		@post.image = post_params[:image] unless post_params[:image].nil?
    @post.upvotes += 1
    @post.upvote << current_person
  	@post.save!
  	current_person.posts << @post
  	current_person.save!

		if @group
			@group = Group.find(params[:group_id ])
    	@group.posts << @post
  		@group.save!
		end

		redirect_to person_posts_path(current_person)
	end

  def vote
    return unless params[:vote]
    if @post.upvote.include?(current_person) || @post.downvote.include?(current_person)
      if @post.upvote.include?(current_person) && params[:vote] == "downvote"
          @post.upvotes -= 1
          @post.upvote.delete(current_person)
          @post.downvotes += 1
          @post.downvote << current_person
        elsif @post.downvote.include?(current_person) && params[:vote] == "upvote"
          @post.downvotes -= 1
          @post.downvote.delete(current_person)
          @post.upvotes += 1
          @post.upvote << current_person
        elsif @post.upvote.include?(current_person) && params[:vote] == "upvote"
          @post.upvotes -= 1
          @post.upvote.delete(current_person)
        else
          @post.downvotes -= 1
          @post.downvote.delete(current_person)
      end
    else
      if params[:vote] == "upvote"
        @post.upvotes += 1
        @post.upvote << current_person
      else
        @post.downvotes += 1
        @post.downvote << current_person
      end
    end
    @post.save!

    redirect_to root_path
  end

	private

	def get_group
		return if params[:group_id ].nil?
		@group = Group.find(params[:group_id ])
	end
  def get_post
    return if params[:id ].nil?
    @post = Post.find(params[:id ])
  end

	def post_params
		params.require(:post).permit(:title, :content, :image)
	end

end
