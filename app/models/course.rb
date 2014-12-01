class Course < ActiveRecord::Base
 
 scope :by_title, -> { order(:title) }

 validates :title, presence: true, uniqueness: true

 has_many :course_researchers
 has_many :researchers, through: :course_researchers
end
