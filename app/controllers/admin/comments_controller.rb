class Admin::CommentsController < Admin::ApplicationController
  before_action :get_comment
  def index
    @comments = Comment.all
  end
  def show
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
