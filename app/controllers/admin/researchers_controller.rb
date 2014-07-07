class Admin::ResearchersController < DashboardController
  def index
    @researchers = Researcher.all
  end

  def show
    @researcher = Researcher.find(params[:id])
  end

  def new
    @researcher = Researcher.new
  end

  def create
    @researcher = Researcher.create(researcher_params)
    if @researcher.save
      redirect_to admin_researchers_path, notice: "You successfully added a new researcher"
    else
      flash[:alert] = "there was a problem, the researcher was not added"
      render :new
    end
  end

  private

  def researcher_params
    params.require(:researcher).permit(:name, :bio, :email, :image)
  end
end
