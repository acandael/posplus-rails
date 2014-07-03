class RenameThemesProjectsToThemeProjects < ActiveRecord::Migration
  def change
    rename_table :themes_projects, :theme_projects
  end
end
