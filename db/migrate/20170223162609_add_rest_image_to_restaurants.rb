class AddRestImageToRestaurants < ActiveRecord::Migration
  def change
    add_attachment :restaurants, :rest_image
  end
end
