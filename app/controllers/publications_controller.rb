class PublicationsController < ApplicationController
  def index

  end

  def show
    @publication = Publication.find(params[:id]) 
  end

  def series
    @publications = Publication.current_year.sort_by_series
    @publications_year = Publication.all.grouped_by_year  
  end

  def archive
    @publications_year = Publication.all.grouped_by_year 
    @year = params[:year]
    @archived_publications = Publication.year(params[:year])
  end
end
