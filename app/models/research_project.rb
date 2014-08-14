class ResearchProject < ActiveRecord::Base
  include Closeable

  validates :title, :body, presence: true

  has_many :theme_projects, dependent: :destroy
  has_many :research_themes, through: :theme_projects

  has_many :project_researchers
  has_many :researchers, through: :project_researchers

  has_many :project_publications
  has_many :publications, through: :project_publications

  mount_uploader :image, ResearchProjectImageUploader

end

