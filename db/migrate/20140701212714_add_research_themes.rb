class AddResearchThemes < ActiveRecord::Migration
  def change
    create_table :research_themes do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
