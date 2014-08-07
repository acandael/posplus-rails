class PublicationsController < ApplicationController
  def index

  end

  def series
    @publications = Publication.all
  end
end
