class PeopleController < ApplicationController 
  def index
    @current_researchers = Researcher.active
    @past_researchers = Researcher.not_active
    fresh_when(@current_researchers)
    fresh_when(@past_researchers)
  end

  def show
    @researcher = Researcher.find(params[:id])
    fresh_when(@researcher)
  end
end
