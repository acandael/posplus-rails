class AddAddressToResearchers < ActiveRecord::Migration
  def change
    add_column :researchers, :address, :text
  end
end
