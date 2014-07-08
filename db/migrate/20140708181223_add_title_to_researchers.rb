class AddTitleToResearchers < ActiveRecord::Migration
  def change
    add_column :researchers, :title, :string
  end
end
