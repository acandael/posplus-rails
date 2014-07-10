class HomesController < ApplicationController
  def index
    @research_themes = ResearchTheme.all
    @news = NewsItem.last(3)
  end
end
