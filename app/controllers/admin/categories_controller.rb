class Admin::CategoriesController < Admin::ApplicationController
  before_action :get_category
  def index
    page = params[:page] ? (params[:page].to_i * 25) : 25
    @categories = Category.all
    @load_more = @categories.length > page ? true : false
    @categories = @categories.limit(page)

  end
  def new
    @category = Category.new
  end
  def create
    @category = Category.create!(params_category)
    redirect_to admin_categories_path()
  end

  def edit
  end

  def update
    @category.update(params_category)
    redirect_to admin_categories_path()
  end

  def show
  end

  def category_index
    page = params[:page] ? (params[:page].to_i * 25) : 25
    if params[:category_id]
      @category = Category.find_by(id: params[:category_id])
      @all_posts = @category.posts
    end
    @load_more = @all_posts.length > page ? true : false
    @posts = @all_posts.limit(page)

  end
  def destroy
    @category.destroy
    redirect_to admin_categories_path()
  end

  private
  def get_category
    return if params[:id].nil?
    @category = Category.find_by(id: params[:id])
  end
  def params_category
    params.require(:category).permit(:title, :about, :color)
  end
end
