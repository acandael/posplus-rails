class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.text :body
      t.string :image
      t.string :document

      t.timestamps
    end
  end
end
