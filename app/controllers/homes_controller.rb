class HomesController < ApplicationController
  def index
    @research_themes = ResearchTheme.all
    @newsitems = NewsItem.last(3)
    @features = Feature.all
  end
end
