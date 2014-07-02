class Admin::ResearchProjectsController < ApplicationController
  def index
    @research_projects = ResearchProject.all
  end

  def show
    @research_project = ResearchProject.find(params[:id])
  end

  def new
    @research_project = ResearchProject.new
  end

  def create
    @research_project = ResearchProject.create(research_project_params)
    redirect_to admin_research_projects_path, notice: "you successfully added a new research project"
  end

  
  private

  def research_project_params
    params.require(:research_project).permit(:title, :body)
  end
end
