class PeopleController < ApplicationController 
  def index
    @current_researchers = Researcher.where(active: true).order(:last_name)
    @past_researchers = Researcher.where(active: false).order(:last_name)
  end

  def show
    @researcher = Researcher.find(params[:id])
  end
end
