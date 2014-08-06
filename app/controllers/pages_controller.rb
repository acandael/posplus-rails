class PagesController < ApplicationController
  def about
    @research_groups = ResearchGroup.all
  end

  def contact

  end
end
