class AddBibliographyToResearchers < ActiveRecord::Migration
  def change
    add_column :researchers, :bibliography, :string
  end
end
