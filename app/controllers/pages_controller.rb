class PagesController < ApplicationController
  def about
    @research_groups = ResearchGroup.all
  end
end
