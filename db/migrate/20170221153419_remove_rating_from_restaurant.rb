class RemoveRatingFromRestaurant < ActiveRecord::Migration
  def change
    remove_column :restaurants, :rating, :string
  end
end
