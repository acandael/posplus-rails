class CreateResearchers < ActiveRecord::Migration
  def change
    create_table :researchers do |t|
      t.string :name
      t.text :bio
      t.string :email
      t.string :image

      t.timestamps
    end
  end
end
