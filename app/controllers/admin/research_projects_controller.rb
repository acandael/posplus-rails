class Admin::ResearchProjectsController < ApplicationController
  def index
    @research_projects = ResearchProject.all
  end

  def show
    @research_project = ResearchProject.find(params[:id])
  end
end
