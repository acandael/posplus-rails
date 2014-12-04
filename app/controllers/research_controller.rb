class ResearchController < ApplicationController
  def index
    @researchthemes = ResearchTheme.all
  end
end
