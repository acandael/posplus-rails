class ResearchController < ApplicationController
  def index
    @research_themes = ResearchTheme.all
  end
end
