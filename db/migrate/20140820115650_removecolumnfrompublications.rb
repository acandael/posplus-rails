class Removecolumnfrompublications < ActiveRecord::Migration
  def change
    remove_column :publications, :document
  end
end
