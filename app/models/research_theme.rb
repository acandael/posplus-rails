class ResearchTheme < ActiveRecord::Base
  validates :title, :description, presence: true

  has_many :theme_projects, dependent: :destroy
  has_many :research_projects, through: :theme_projects
end
