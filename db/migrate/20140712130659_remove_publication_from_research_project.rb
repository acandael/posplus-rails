class RemovePublicationFromResearchProject < ActiveRecord::Migration
  def change
    remove_column :research_projects, :publication_id
  end
end
