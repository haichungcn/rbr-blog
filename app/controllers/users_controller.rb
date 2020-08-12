class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, except: %i[index show create new]
  before_action :require_same_user, only: %i[edit update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User #{@user.name} was successfully created."
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'User info was successfully updated.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'User and all posts have been deleted'
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def require_same_user
    return if current_user == @user || current_user.admin?

    flash[:warning] = 'You do not have the authorization to perform this action'
    redirect_to root_path
  end

  def require_admin
    return if current_user.admin?

    flash[:warning] = 'You do not have the authorization to perform this action'
    redirect_to users_path
  end
end
