class ResearchProject < ActiveRecord::Base
  validates :title, :body, presence: true

  has_many :theme_projects, dependent: :destroy
  has_many :research_themes, through: :theme_projects

  has_many :project_researchers
  has_many :researchers, through: :project_researchers

  has_many :publications

  mount_uploader :image, ResearchProjectImageUploader

  def open?
    active
  end

  def toggle_active!
    if open?
      update_attribute(:active, false)
    else
      update_attribute(:active, true)
    end
  end
end
