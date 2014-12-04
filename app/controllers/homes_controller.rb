class HomesController < ApplicationController
  def index
    @researchthemes = ResearchTheme.all
    @newsitems = NewsItem.last(3)
    @features = Feature.all
  end
end
