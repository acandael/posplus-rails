class HomesController < ApplicationController
  def index
    @research_themes = ResearchTheme.all
    @news = NewsItem.last(3)
    @features = Feature.all
  end
end
