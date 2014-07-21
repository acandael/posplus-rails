class Researcher < ActiveRecord::Base
  validates :name, presence: :true, uniqueness: :true
  validates :bio, presence: :true

  has_many :project_researchers
  has_many :research_projects, through: :project_researchers
  
  has_many :course_researchers
  has_many :courses, through: :course_researchers

  mount_uploader :image, ResearcherImageUploader

  def visible?
    visible
  end

  def toggle_visibility!
    if visible?
      update_attribute(:visible, false)
    else
      update_attribute(:visible, true)
    end
  end
end
