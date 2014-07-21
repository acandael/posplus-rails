class AddActiveToResearchProjects < ActiveRecord::Migration
  def change
    add_column :research_projects, :active, :boolean
  end
end
