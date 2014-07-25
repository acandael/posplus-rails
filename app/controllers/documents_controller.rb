class DocumentsController < ApplicationController
  def index
    @publications = Publication.all
  end
end
