class PersonsController < ApplicationController
  layout "groups"
  before_action :get_user
  before_action :get_post

  def profile
  end

  def overview
    # tam thoi de day, chú ý khi xong thì chuyển xống index
    case params[:view]
    when 'posts'
      @array = @person.posts.all.to_a.sort { |x, y | y.created_at <=> x.created_at }
    when 'save'
      @array = @person.posts_saved
    when 'comments'
      @comments = current_person.comments
    when 'hidden'
      @array = @person.posts_hidden
    when 'upvoted'
      @array = @person.upvote
    when 'downvoted'
      @array = @person.downvote
    else
      comments = @person.comments.to_a
      posts = @person.posts.to_a
      @array = comments + posts
      @array = @array.sort { |x, y | y.created_at <=> x.created_at }
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
  end

  def comments
    @comments = current_person.comments.all
  end

  def saved

  end

  def hidden
    @posts = @person.posts_hidden
  end

  def upvoted
  end

  def downvoted
  end

  def all_settings
  end

  def account
  end

  def user_profile
  end

  def feed
  end

  def post_options
  	case params[:option] 
    when "save"
      if current_person.posts_saved.include?(@post)
        current_person.posts_saved.delete(@post)
        @save_option = "Save"
        @message = "Post unsaved successfully."
      else
        current_person.posts_saved << @post
        @save_option = "Unsave"
        @message = "Post saved successfully."
      end

    when "hide"
      if current_person.posts_hidden.include?(@post)
        current_person.posts_hidden.delete(@post)
        @hide_option = "Hide"
        @message = "Post unhidden successfully."
      else
        current_person.posts_hidden << @post
        @hide_option = "Unhide"
        @message = "Post hidden successfully."
      end

    when "delete"
    	@post.destroy
        @delete_option = "delete"
        @message = "Post delete successfully."
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def account_setting
    if params[:person][:avatar]
      current_person.avatar = params[:person][:avatar]
      current_person.save!
    end
    if params[:person][:banner]
      current_person.banner = params[:person][:banner]
      current_person.save!
    end
  end

  def profile_setting
  end

  def feed_setting
  end

  def follow
    if params[:type] == 'follows'
      @person.followers << current_person
      current_person.followings << @person
    else
      @person.followers.delete(current_person)
      current_person.followings.delete(@person)
    end
    respond_to do |format|
      format.html
      format.js {render :follow}
    end
  end

  private

  def get_user
    return unless params[:id]
    @person = Person.find(params[:id])
  end

  def get_post
    return unless params[:post_id]
    @post = Post.find_by(id: params[:post_id])
  end

end
