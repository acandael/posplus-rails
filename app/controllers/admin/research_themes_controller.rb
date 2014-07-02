class Admin::ResearchThemesController < ApplicationController
  def index
    @research_themes = ResearchTheme.all
  end

  def new
    @research_theme = ResearchTheme.new
  end

  def edit
    @research_theme = ResearchTheme.find(params[:id])
  end

  def create
    @research_theme = ResearchTheme.create(research_theme_params)
    @research_theme.save
    redirect_to admin_research_themes_path
  end

  def update
    @research_theme = ResearchTheme.find(params[:id])
    @research_theme.update_attributes(research_theme_params)
    redirect_to admin_research_themes_path
  end

  private

  def research_theme_params
    params.require(:research_theme).permit(:title, :description)
  end
end
