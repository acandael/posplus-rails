class PeopleController < ApplicationController 
  def index
    @current_researchers = Researcher.active
    @past_researchers = Researcher.not_active
  end

  def show
    @researcher = Researcher.find(params[:id])
  end
end
