class Admin::ResearchProjectsController < DashboardController 
  def index
    @research_projects = ResearchProject.all.order(:created_at)
  end

  def show
    @research_project = ResearchProject.find(params[:id])
  end

  def new
    @research_project = ResearchProject.new
  end

  def edit
    @research_project = ResearchProject.find(params[:id])
  end

  def create
    @research_project = ResearchProject.create(research_project_params)
    if @research_project.save
      redirect_to admin_research_projects_path, notice: "you successfully added a new research project"
    else
      flash[:alert] = @research_project.errors.full_messages.join(' ') 
      render :new
    end
  end

  def update
    @research_project = ResearchProject.find(params[:id])
    if @research_project.update(research_project_params)
    redirect_to admin_research_projects_path, notice: "you successfully updated the research project"
    else
      flash[:alert] = @research_project.errors.full_messages.join(' ') 
      render :edit
    end
  end

  def destroy
    research_project = ResearchProject.find(params[:id])
    research_project.destroy
    redirect_to admin_research_projects_path, notice: "you successfully removed the research project"
  end

  def close
    @research_project = ResearchProject.find(params[:id])
    @research_project.toggle_active!
    render "close.js.erb"
  end

  
  private

  def research_project_params
    params.require(:research_project).permit(:title, :body, :image, :active, :research_theme_ids => [])
  end
end
