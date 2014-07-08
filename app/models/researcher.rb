class Researcher < ActiveRecord::Base
  validates :name, presence: :true, uniqueness: :true
  validates :bio, presence: :true

  has_many :project_researchers
  has_many :research_projects, through: :project_researchers

  mount_uploader :image, ResearcherImageUploader
end
