class AddImageToResearchProjects < ActiveRecord::Migration
  def change
    add_column :research_projects, :image, :string
  end
end
