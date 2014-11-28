class PublicationsController < ApplicationController
  def index

  end

  def show
    @publication = Publication.find(params[:id]) 
  end

  def series
    @current_publications = Publication.by_current_year
    @publications_year = Publication.all.grouped_by_year  
  end

  def archive
    @publications_year = Publication.all.grouped_by_year 
    @year = params[:year]
    @archived_publications = Publication.by_year(@year)
  end
end
