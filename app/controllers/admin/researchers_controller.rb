class Admin::ResearchersController < DashboardController
  def index
    @researchers = Researcher.all
  end
end
