class Admin::PostsController < Admin::ApplicationController
  before_action :get_post
  def index
    @posts = Post.all
  end

  def show
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
