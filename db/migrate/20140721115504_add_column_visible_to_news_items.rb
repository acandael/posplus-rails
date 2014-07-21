class AddColumnVisibleToNewsItems < ActiveRecord::Migration
  def change
    add_column :news_items, :visible, :boolean
  end
end

