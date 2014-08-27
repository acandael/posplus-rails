class AddPhoneResearchers < ActiveRecord::Migration
  def change
    add_column :researchers, :phone, :string

  end
end
