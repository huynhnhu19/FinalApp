class GroupsController < ApplicationController
  def index
  	@groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @post = @group.posts.new
    @comment = @post.comments.new
    @reply = @comment.replies.new
  end

  def new
  	@group = current_person.groups.new
  end

  def create
  	@group = Group.create!(group_params)
  	@group.author = current_person
  	redirect_to root_path()
  end

  def join
  	@group = Group.find(params[:id])
  	@group.members << current_person
  	redirect_to root_path()
  end

  # def create_post
  #   @group = Group.find(params[:id])
  #   @post = Post.create!(post_params)
  #   @post.image = post_params[:image] unless post_params[:image].nil?
  #   @group.posts << @post
  #   @group.save!
  #   current_person.posts << @post
  #   current_person.save!
  # end

  private
  def group_params
  	params.require(:group).permit(:group_name)
  end
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
