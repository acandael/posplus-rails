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

  def edit
    @research_project = ResearchProject.find(params[:id])
  end

  def create
    @research_project = ResearchProject.create(research_project_params)
    if @research_project.save
      redirect_to admin_research_projects_path, notice: "you successfully added a new research project"
    else
      flash.alert = "there was a problem, the research project was not added"
      render :new
    end
  end

  def update
    @research_project = ResearchProject.find(params[:id])
    if @research_project.update_attributes(research_project_params)
    redirect_to admin_research_projects_path, notice: "you successfully updated the research project"
    else
      flash.alert =  "there was a problem, the research project could not be updated"
      render :edit
    end
  end

  

  
  private

  def research_project_params
    params.require(:research_project).permit(:title, :body)
  end
end
