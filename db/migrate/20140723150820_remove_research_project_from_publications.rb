class RemoveResearchProjectFromPublications < ActiveRecord::Migration
  def change
    remove_column :publications, :research_project_id
  end
end
