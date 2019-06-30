class Admin::CategoriesController < Admin::ApplicationController
  before_action :get_category
  def index
    @categories = Category.all
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
