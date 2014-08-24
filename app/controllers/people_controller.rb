class PeopleController < ApplicationController 
  def index
    @researchers = Researcher.all.order(:last_name)
  end

  def show
    @researcher = Researcher.find(params[:id])
  end
end
