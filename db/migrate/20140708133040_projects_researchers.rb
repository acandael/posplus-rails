class ProjectsResearchers < ActiveRecord::Migration
  def change
    create_table :projects_researchers do |t|
      t.references :research_project, :researcher
    end
  end
end
