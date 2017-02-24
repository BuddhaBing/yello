class AddTelephoneToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :telephone, :string
  end
end
