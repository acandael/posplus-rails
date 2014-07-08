class RenameProjectsResearchers < ActiveRecord::Migration
  def change
    rename_table :projects_researchers, :project_researchers
  end
end
