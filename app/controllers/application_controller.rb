class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to new_session_url, alert: "Please sign in first!"
    end
  end


  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to signin_path unless current_user
  end

  def current_user_admin?
    current_user && current_user.admin?
  end


  helper_method :current_user
  helper_method :current_user_admin?
end
