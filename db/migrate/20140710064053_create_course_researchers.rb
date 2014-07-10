class CreateCourseResearchers < ActiveRecord::Migration
  def change
    create_table :course_researchers do |t|
      t.references :course, :researcher
    end
  end
end
