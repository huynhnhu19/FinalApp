class Admin::PostsController < Admin::ApplicationController
  before_action :get_post
  def index
    page = params[:page] ? (params[:page].to_i * 25) : 25
    @posts = Post.all
    @load_more = @posts.length > page ? true : false
    @posts = @posts.limit(page)
  end

  def show
  end

  def post_index
    page = params[:page] ? (params[:page].to_i * 25) : 25
    if params[:person_id]
      @person = Person.find_by(id: params[:person_id])
      @all_posts = @person.posts
      @header = @person.full_name
    elsif params[:group_id]
      @group = Group.find_by(id: params[:group_id])
      @all_posts = @group.posts
      @header = "#{@group.group_name} Community"
    end
    @load_more = @all_posts.length > page ? true : false
    @posts = @all_posts.limit(page)
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path()
  end

  private
  def get_post
    return if params[:id].nil?
    @post = Post.find_by(id: params[:id])
  end

end
