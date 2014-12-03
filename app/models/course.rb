class Course < ActiveRecord::Base
 
 scope :by_created_at, ->{ order(created_at: :desc) }

 validates :title, presence: true, uniqueness: true

 has_many :course_researchers
 has_many :researchers, through: :course_researchers
end
