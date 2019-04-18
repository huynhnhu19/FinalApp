class PersonsController < ApplicationController
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

end
