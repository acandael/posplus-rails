class RenameResearchProjectPublications < ActiveRecord::Migration
  def change
    rename_table :research_project_publications, :project_publications
  end
end
