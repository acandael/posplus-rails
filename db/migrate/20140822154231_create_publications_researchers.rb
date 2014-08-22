class CreatePublicationsResearchers < ActiveRecord::Migration
  def change
    create_table :publications_researchers do |t|
      t.references :publication, :researcher
    end
  end
end
