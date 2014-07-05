class Admin::DashboardController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin  

  private

  def require_admin
    unless current_user.admin?
      flash.now[:alert] = "Unauthorized acces!"
      redirect_to home_path
    end
  end
end
