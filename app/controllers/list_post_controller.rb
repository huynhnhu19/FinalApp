class ListPostController < ApplicationController
	def index
		@list_post = Post.all
	end
end
