class CreateResearchProjects < ActiveRecord::Migration
  def change
    create_table :research_projects do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
