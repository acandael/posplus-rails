class AddColumnVisibleToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :visible, :boolean
  end
end
