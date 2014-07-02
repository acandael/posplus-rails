class ResearchTheme < ActiveRecord::Base
  validates :title, :description, presence: true
end
