class RenameColumnResearchers < ActiveRecord::Migration
  def change
    rename_column :researchers, :name, :first_name 
  end
end
