class ResearchThemesController < ApplicationController
  def show
    @research_theme = ResearchTheme.find(params[:id])
  end
end
