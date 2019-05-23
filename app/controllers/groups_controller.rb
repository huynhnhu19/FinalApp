class GroupsController < ApplicationController
  layout "groups"
  before_action :get_group
  def index
  	@groups = Group.all
  end

  def show
    @post = @group.posts.new
    @comment = @post.comments.new
    @reply = @comment.replies.new
    @posts = @group.posts.all
    @posts = @posts.order(created_at: :desc) if params[:order_sort] == 'new'
    @posts = @posts.order(upvotes: :desc) if params[:order_sort] == 'hot'
    @posts = @posts.order(controversial: :desc) if params[:order_sort] == 'controversial'

    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @posts = @group.posts.all
  end

  def new
  	@group = current_person.groups.new
    render layout: 'persons'
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
  	@group = Group.create!(group_params)
    @group.icon = group_params[:icon] if group_params[:icon].present?
    @group.banner = group_params[:banner] if group_params[:banner].present?
  	@group.author = current_person
    @group.save!
  	redirect_to root_path()
  end

  def join
  	@group.members << current_person
    respond_to do |format|
      format.html
      format.js
    end
  end

  def leave
    @group.members.delete current_person
    respond_to do |format|
      format.html
      format.js {render :join}
    end
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
  def get_group
    return unless params[:id]
    @group = Group.find(params[:id])
  end
  def group_params
  	params.require(:group).permit(:group_name, :about, :icon, :banner, :them, :text_color)
  end
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
