class CourseResearcher < ActiveRecord::Base
  belongs_to :course
  belongs_to :researcher
end
