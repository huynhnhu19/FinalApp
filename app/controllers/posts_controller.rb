class PostsController < ApplicationController
	before_action :get_group, :get_post, :get_user, :get_category
	def index
		@posts = @person.posts.all.order(updated_at: :asc).page(1).per 10
		# @post = Post.find(params[:id])
		# @time = Time.now.min - @post.created_at.min
	end

	def show
		@post = Post.find(params[:id])
		@comment = @post.comments.new
    @list_post_comments = @post.comments.where(type: :comment)
		@new_reply = Comment.new
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

		if @group
      if @group.type.in?([:private, :restricted])
        @group.unapprove_posts << @post
      else
        @group.post << @post
      end
		end
    if @category
      @post.category = @category
      @category.posts << @post
    end

		redirect_to overview_person_path(current_person)
	end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update!(post_params.to_h)
    @post.category.posts.delete(@post) if @post.category
    if @category
      @post.category = @category
      @category.posts << @post
      @post.save
    end
    redirect_to overview_person_path(current_person)
  end

  def vote
    return unless params[:vote]
    @view = "index" if params[:view] == 'index'
    if @post.upvote.include?(current_person) || @post.downvote.include?(current_person)
      if @post.upvote.include?(current_person) && params[:vote] == "downvote"
          # post
          @post.upvotes -= 1
          @post.upvote.delete(current_person)
          @post.downvotes += 1
          @post.downvote << current_person
          @color = 'purple'
          # person
          current_person.upvote.delete(@post)
          current_person.downvote<< @post
        elsif @post.downvote.include?(current_person) && params[:vote] == "upvote"
          @post.downvotes -= 1
          @post.downvote.delete(current_person)
          @post.upvotes += 1
          @post.upvote << current_person
          # person
          current_person.upvote << @post
          current_person.downvote.delete(@post)
          @color = "red"
        elsif @post.upvote.include?(current_person) && params[:vote] == "upvote"
          @post.upvotes -= 1
          @post.upvote.delete(current_person)
          current_person.upvote.delete(@post)
          @color = "none"
        else
          @post.downvotes -= 1
          @post.downvote.delete(current_person)
          current_person.downvote.delete(@post)
          @color = "none"
      end
    else
      if params[:vote] == "upvote"
        @post.upvotes += 1
        @post.upvote << current_person
        current_person.upvote << @post
        @color = "red"
      else
        @post.downvotes += 1
        @post.downvote << current_person
        current_person.downvote << @post
        @color = 'purple'
      end
    end
    @view = "index"
    @post.save!
    current_person.save!
    respond_to do |format|
      format.html
      format.js
    end
  end

	private
  def get_category
    return unless params[:post]
    @category = Category.find_by(id: params[:post][:category])
  end
	def get_group
		return if params[:group_id ].nil?
		@group = Group.find(params[:group_id ])
	end
  def get_post
    return if params[:id ].nil?
    @post = Post.find(params[:id ])
  end

	def post_params
		params.require(:post).permit(:title, :content, :image, :is_question)
	end

  def get_user
    return unless params[:person_id]
    @person = Person.find(params[:person_id])
  end
end
