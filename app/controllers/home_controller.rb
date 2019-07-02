class HomeController < ApplicationController
	def index
		@person = Person.all
		@groups = Group.all
	    @private_groups = Group.where(type: :private)
	    # get post
	    @posts = Post.all.where(post_creation: false)
	    # remove private posts
		@posts = @posts.to_a - @private_groups.posts

	  	if current_person
	  		@hidden_post = current_person.posts_hidden
	  		@posts = @posts.to_a - @hidden_post.to_a
	  	end
		@posts = @posts.sort { |x, y | y.created_at <=> x.created_at } if params[:order_sort] == 'new'
		@posts = @posts.sort { |x, y | y.upvotes <=> x.upvotes } if params[:order_sort] == 'hot'
		@posts = @posts.order(controversial: :desc) if params[:order_sort] == 'controversial'
		if params[:subject]
			@posts = @posts.select { |x| x.category && x.category.title == params[:subject] }
		end

		respond_to do |format|
  			format.html
  			format.js
    	end
	end

	def search
		return unless params[:search]
		@groups = Group.where(['group_name LIKE ?', "%#{params[:search]}%"])
		@posts = Post.all
		respond_to do |format|
  			format.html
  			format.js
    	end
	end
  def alert
    @message = params[:message]
    respond_to do |format|
        format.html
        format.js
      end
  end
end