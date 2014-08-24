class AddColumnResearchers < ActiveRecord::Migration
  def change
    add_column :researchers, :last_name, :string
  end
end
