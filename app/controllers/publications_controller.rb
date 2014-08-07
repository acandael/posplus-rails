class PublicationsController < ApplicationController
  def series
    @publications = Publication.all
  end
end
