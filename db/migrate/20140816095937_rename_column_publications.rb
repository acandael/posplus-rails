class RenameColumnPublications < ActiveRecord::Migration
  def change
    rename_column :publications, :reference, :body
  end
end
