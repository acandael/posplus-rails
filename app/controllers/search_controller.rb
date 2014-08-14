class SearchController < ApplicationController
  def search
    @search_term = params[:q]
    if params[:q].nil?
      @publications = []
    else
      @publications = Publication.search params[:q] 
    end
  end
end
