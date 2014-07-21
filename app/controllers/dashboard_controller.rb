class DashboardController < AuthenticatedController
  before_filter :require_admin  

  private

  def require_admin
    unless current_user_admin?
      flash[:alert] = "Unauthorized access!"
      redirect_to home_path
    end
  end
end




