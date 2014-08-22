class RenamePublicationsResearchers < ActiveRecord::Migration
  def change
    rename_table :publications_researchers, :publication_researchers
  end
end
