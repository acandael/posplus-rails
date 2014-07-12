class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.integer :research_project_id

      t.timestamps
    end
  end
end
