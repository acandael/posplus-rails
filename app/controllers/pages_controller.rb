class PagesController < ApplicationController
  def about
    @researchgroups = ResearchGroup.all
  end

  def contact

  end
end
