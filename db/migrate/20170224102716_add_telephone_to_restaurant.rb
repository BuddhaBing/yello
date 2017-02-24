class AddTelephoneToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :telephone, :bigint
  end
end
