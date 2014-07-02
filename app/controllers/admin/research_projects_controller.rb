class Admin::ResearchProjectsController < ApplicationController
  def index
    @research_projects = ResearchProject.all
  end
end
