class ResearchProject < ActiveRecord::Base
  validates :title, :body, presence: true

  has_many :theme_projects
  has_many :research_themes, through: :theme_projects
end
