# Categories Controller
class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[index show]
  before_action :set_category, only: %i[show edit update]
  # before_action :require_same_user, only: %i[edit update destroy]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category was created successfully'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category name was successfully updated'
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    return if logged_in? && current_user.admin?

    flash[:danger] = 'Only admins can perform that action'
    redirect_to categories_path
  end
end
