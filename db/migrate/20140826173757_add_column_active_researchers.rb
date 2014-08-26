class AddColumnActiveResearchers < ActiveRecord::Migration
  def change
    add_column :researchers, :active, :boolean, default: true
  end
end
