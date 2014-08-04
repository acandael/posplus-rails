class CreateResearchGroups < ActiveRecord::Migration
  def change
    create_table :research_groups do |t|
      t.string :name
      t.string :image
      t.string :url
    end
  end
end
