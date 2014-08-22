class Researcher < ActiveRecord::Base
  include Hideable

  validates :name, presence: true, uniqueness: :true
  validates :bio, presence: true
  validates :email, presence: true

  has_many :project_researchers
  has_many :research_projects, through: :project_researchers
  
  has_many :course_researchers
  has_many :courses, through: :course_researchers

  has_many :publication_researchers
  has_many :publications, through: :publication_researchers

  mount_uploader :image, ResearcherImageUploader

end
