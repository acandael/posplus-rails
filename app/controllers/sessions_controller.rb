class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_path
    else
      flash.now[:alert] = "Wrong Email/Password combination"
      render :new    
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are signed out!"
  end
end
