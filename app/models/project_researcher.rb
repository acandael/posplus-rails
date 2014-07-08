class ProjectResearcher < ActiveRecord::Base
  belongs_to :research_project
  belongs_to :researcher
end
