class PublicationsController < ApplicationController
  def index

  end

  def series
    @publications = Publication.all
    @publications_year = @publications.group_by { |p| p.created_at.beginning_of_year }
  end

  def archive
    publications = Publication.all
    @publications_year = publications.group_by { |p| p.created_at.beginning_of_year }
    @year = params[:year]
    @archived_publications = Publication.where('extract(year from created_at) = ?', @year)
  end
end
