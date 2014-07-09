class ResearchProjectsController < ApplicationController
  def show
    @research_project = ResearchProject.find(params[:id])
  end
end
