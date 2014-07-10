class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :title
      t.text :body
      t.string :image
      t.string :document
      t.string :link

      t.timestamps
    end
  end
end
