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

  def edit
    @researcher = Researcher.find(params[:id])
  end

  def create
    @researcher = Researcher.create(researcher_params)
    if @researcher.save
      redirect_to admin_researchers_path, notice: "You successfully added a new researcher"
    else
      flash[:alert] = @researcher.errors.full_messages.join(' ') 
      render :new
    end
  end

  def update
    @researcher = Researcher.find(params[:id])
    if @researcher.update_attributes(researcher_params)
      redirect_to admin_researchers_path, notice: "you successfully updated the researcher"
    else
      flash[:alert] = @researcher.errors.full_messages.join(' ')
      render :edit
    end
  end

  def destroy
    researcher = Researcher.find(params[:id])
    researcher.destroy
    redirect_to admin_researchers_path, notice: "You successfully removed the researcher"
  end

  private

  def researcher_params
    params.require(:researcher).permit(:name, :bio, :email, :image, :research_project_ids => [])
  end
end
