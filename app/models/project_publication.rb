class ProjectPublication < ActiveRecord::Base
  belongs_to :research_project
  belongs_to :publication
end
