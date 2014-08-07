class AddColumnCategory < ActiveRecord::Migration
  def change
    add_column :publications, :category_id, :integer
  end
end
