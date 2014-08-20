class AddDocumentToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :document, :string
  end
end
