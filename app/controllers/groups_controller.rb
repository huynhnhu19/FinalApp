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
    @posts = @group.unapprove_posts
    case params[:option]
    when 'mod_queue'
      @posts = @group.unapprove_posts
    when 'unpprove_posts'
      @posts = @group.unapprove_posts
    when 'approved'
      @unapprove_members = @group.unapprove_members
    when 'members'
      @members = @group.members
    when 'banned'
      @members = @group.banned_members
    when 'muted'
      @members = @group.muted_members
    end
    respond_to do |format|
      format.html
      format.js
    end
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
      if @group.members.include?(current_person)
       @group.members.delete(current_person)
        current_person.join_groups.delete(@group)
      else
    	 @group.members << current_person
        current_person.join_groups << @group
      end
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
      current_person.join_groups.delete(@group)
      respond_to do |format|
        format.html
        format.js {render :join}
      end
    end
  end

  def user_approved
    @person = Person.find_by(id: params[:person_id])
    @group.unapprove_members.delete(@person)
    @group.members << @person
    params[:option] = 'approved'
    @unapprove_members = @group.unapprove_members
    respond_to do |format|
        format.html
        format.js {render :edit}
    end
  end

  def manage_user
    @person = Person.find_by(id: params[:person_id])
    case params[:option]
    when 'ban'
      if @group.banned_members.include?(@person)
        @group.banned_members.delete @person
      else
        @group.banned_members << @person
      end
    when "mute"
      if @group.muted_members.include?(@person)
        @group.muted_members.delete @person
      else
        @group.muted_members << @person
      end
    end
    @members = @group.members
    params[:option] = 'members'
    respond_to do |format|
      format.html
      format.js {render :edit}
    end
  end

  def user_banned
    @person = Person.find_by(id: params[:person_id])
    if @group.banned_members.include?(@person)
      @group.banned_members.delete @person
    else
      @group.banned_members << @person
    end
    @members = @group.banned_members
    respond_to do |format|
      format.html
      format.js {render}
    end
  end

  def user_muted
    @person = Person.find_by(id: params[:person_id])
    if @group.muted_members.include?(@person)
      @group.muted_members.delete @person
    else
      @group.muted_members << @person
    end
    @members = @group.muted_members
    respond_to do |format|
      format.html
      format.js {render}
    end
  end

  def post_approved
    @post = Post.find_by(id: params[:post_id])
    if @group.unapprove_posts.include?(@post)
      @group.unapprove_posts.delete(@post)
      @group.posts << @post
    else
      @group.unapprove_posts << (@post)
      @group.posts.delete @post
    end
  end

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
