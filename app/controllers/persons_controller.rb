class PersonsController < ApplicationController
  layout "persons"

  def profile
  end

  def overview
    # tam thoi de day, chú ý khi xong thì chuyển xống index
    @posts = current_person.posts.all.order(updated_at: :asc)
  end

  def index
  end

  def comments
    @comments = current_person.comments.all
  end

  def saved
  end

  def hidden
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

  def account_setting
  end

  def profile_setting
  end

  def feed_setting
  end

end
