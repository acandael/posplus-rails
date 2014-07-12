class AddReferenceToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :reference, :text
  end
end
