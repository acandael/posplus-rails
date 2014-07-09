class PeopleController < ApplicationController 
  def index
    @researchers = Researcher.all
  end

  def show
    @researcher = Researcher.find(params[:id])
  end
end
