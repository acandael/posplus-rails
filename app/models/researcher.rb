class Researcher < ActiveRecord::Base
  include Hideable

  scope :active, ->{ where(active: true).order(:last_name) }
  scope :not_active, ->{ where(active: false).order(:last_name) }
  scope :by_last_name, ->{ order(:last_name) }

  validates :first_name, :last_name, presence: true
  validates :last_name, :uniqueness => { :scope => :first_name }
  validates :bio, presence: true
  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }

  validates_length_of :title, maximum: 30
  validates :image, format: { :with => /\.(png|gif|jpg|jpeg)\z/i },
                      allow_blank: true

  validate :image_size

  has_many :project_researchers
  has_many :research_projects, through: :project_researchers
  
  has_many :course_researchers
  has_many :courses, through: :course_researchers

  has_many :publication_researchers
  has_many :publications, through: :publication_researchers

  mount_uploader :image, ResearcherImageUploader

  def fullname
  "#{first_name} #{last_name}"
  end

  private

  def image_size
    if image.size > 3.megabytes
      errors.add(:image, "should be less than 3MB")
    end
  end
  

end
