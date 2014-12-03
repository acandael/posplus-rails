class AddTimestampsToResearchGroups < ActiveRecord::Migration
  def change
    add_column :research_groups, :created_at, :datetime
    add_column :research_groups, :updated_at, :datetime
  end
end
