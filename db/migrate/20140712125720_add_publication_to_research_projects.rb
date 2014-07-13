class AddPublicationToResearchProjects < ActiveRecord::Migration
  def change
    add_column :research_projects, :publication_id, :integer
  end
end
