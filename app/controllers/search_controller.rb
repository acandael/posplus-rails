class SearchController < ApplicationController
  def search
    @search_term = params[:q]
    if params[:q].nil?
      @publications = []
      @research_projects = []
    else
      @publications = Publication.search params[:q] 
      @research_projects = ResearchProject.search params[:q]
    end
  end
end
