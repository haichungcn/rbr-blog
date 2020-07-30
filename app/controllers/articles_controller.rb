class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:success] = "Article was successfully created."
      redirect_to @article
    else
      render 'new'
    end
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "Article was successfully destroyed."

    redirect_to articles_path
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :text)
    end

    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:warning] = "You do not have the authorization to perform this action"
        redirect_to root_path
      end
    end
end
