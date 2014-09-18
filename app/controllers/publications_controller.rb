class PublicationsController < ApplicationController
  def index

  end

  def show
    @publication = Publication.find(params[:id]) 
  end

  def series
    @current_publications = Publication.where('year = ?', Time.now.year)
    publications = Publication.all
    @publications_year = publications.order('year DESC').group_by { |p| p.year}
  end

  def archive
    publications = Publication.all
    @publications_year = publications.order('year DESC').group_by { |p| p.year }
    @year = params[:year]
    @archived_publications = Publication.where('year = ?', @year)
  end
end
