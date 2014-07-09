class PeopleController < ApplicationController 
  def index
    @researchers = Researcher.all
  end
end
