class AddSeriesToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :series, :integer
  end
end
