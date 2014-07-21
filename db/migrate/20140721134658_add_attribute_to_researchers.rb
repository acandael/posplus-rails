class AddAttributeToResearchers < ActiveRecord::Migration
  def change
    change_column :researchers, :visible, :boolean, { default: true } 
  end
end
