class CreateThemesProjects < ActiveRecord::Migration
  def change
    create_table :themes_projects do |t|
      t.references :research_theme, :research_project
    end
  end
end
