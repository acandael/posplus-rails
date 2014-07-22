class AddColumnToResearchThemes < ActiveRecord::Migration
  def change
    add_column :research_themes, :image, :string
  end
end
