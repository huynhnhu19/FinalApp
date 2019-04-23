class PostsController < ApplicationController
  layout "persons"
	before_action :get_group
	def index
		@posts = current_person.posts.all.order(updated_at: :asc)
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

	private
	def get_group
		return if params[:group_id ].nil?
		@group = Group.find(params[:group_id ])
	end

	def post_params
		params.require(:post).permit(:title, :content, :image)
	end

end
