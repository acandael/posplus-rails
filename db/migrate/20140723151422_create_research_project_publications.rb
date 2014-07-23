class CreateResearchProjectPublications < ActiveRecord::Migration
  def change
    create_table :research_project_publications do |t|
      t.references :research_project, :publication
    end
  end
end
