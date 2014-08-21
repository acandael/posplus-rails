class AddYearToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :year, :integer
  end
end
