class RenameColumnResearchGroups < ActiveRecord::Migration
  def change
    rename_column :research_groups, :url, :website
  end
end
