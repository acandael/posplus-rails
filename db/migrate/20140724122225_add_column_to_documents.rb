class AddColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :publication_id, :integer
  end
end
