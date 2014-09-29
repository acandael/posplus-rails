class ResearchTheme < ActiveRecord::Base
  before_destroy :check_for_projects
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image, format: { :with => /\.(png|gif|jpg|jpeg)\z/i },
                      allow_blank: true
  validate :image_size

  has_many :theme_projects, dependent: :destroy
  has_many :research_projects, through: :theme_projects

  mount_uploader :image, ResearchThemeImageUploader


  private

  def check_for_projects
    if research_projects.any?
      errors[:base] << "cannot delete research theme that still has research projects"
      return false
    end
  end

  def image_size
    if image.size > 3.megabytes
      errors.add(:image, "should be less than 3MB")
    end
  end
end
