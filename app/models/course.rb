class Course < ActiveRecord::Base
 validates :title, presence: true 

 has_many :course_researchers
 has_many :researchers, through: :course_researchers
end
