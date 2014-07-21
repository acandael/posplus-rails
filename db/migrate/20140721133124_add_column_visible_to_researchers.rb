class AddColumnVisibleToResearchers < ActiveRecord::Migration
  def change
    add_column :researchers, :visible, :boolean
  end
end
