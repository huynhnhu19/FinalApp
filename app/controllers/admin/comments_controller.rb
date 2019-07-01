class Admin::CommentsController < Admin::ApplicationController
  before_action :get_comment
  def index
    page = params[:page] ? (params[:page].to_i * 25) : 25
    @comments = Comment.all
    @load_more = @comments.length > page ? true : false
    @comments = @comments.limit(page)
  end
  def show
  end

  def comment_index
    page = params[:page] ? (params[:page].to_i * 25) : 25
    if params[:post_id]
      @post = Post.find_by(id: params[:post_id])
      @all_comments = @post.comments
    end
    @load_more = @all_comments.length > page ? true : false
    @comments = @all_comments.limit(page)

  end
  def destroy
    @comment.destroy
    redirect_to admin_comment_path()
  end
  private
  def get_comment
    return if params[:id].nil?
    @comment = Comment.find_by(id: params[:id])
  end
end
