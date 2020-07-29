class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:warning] = "You are already logged in"
      redirect_to root_path
    end
  end

  def create
    if logged_in?
      flash[:warning] = "You are already logged in"
      redirect_to root_path
    end
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Invalid email or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

end