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
  	@group = Group.new(group_params)
    @group.icon = group_params[:icon] if group_params[:icon].present?
    @group.banner = group_params[:banner] if group_params[:banner].present?
  	@group.author = current_person
    @group.members << current_person
    @group.save!
  	redirect_to group_path(@group)
  end

  def join
    if @group.type == :private
      if @group.unapprove_members.include?(current_person)
        btn_label =
        @group.unapprove_members.delete(current_person)
      else
        @group.unapprove_members << current_person
      end
    else
    	@group.members << current_person
      current_person.join_groups << @group
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def leave
    if @group.author == current_person
      flash[:error] = "You are the Leader of this Community. Cannot leave!"
      redirect_to :root
    else
      @group.members.delete current_person
      respond_to do |format|
        format.html
        format.js {render :join}
      end
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
  	params.require(:group).permit(:group_name, :about, :icon, :banner, :them, :text_color, :type)
  end
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
