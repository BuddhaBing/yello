require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it "is not valid with a name of less than 3 chars" do
    restaurant = Restaurant.new(name:"na", user_id: 1)
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
  
  it "is not valid unless it has a unique name" do
    user = User.create! :user_name => 'John Doe', :email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
    Restaurant.create!(name: "Nandos", description: "Cheeky", user_id: user.id)
    restaurant = Restaurant.new(name: "Nandos", description: "Cheeky", user_id: user.id)
    expect(restaurant).to have(1).error_on(:name)
  end
  
  describe "#rating" do
    it "returns an average rating from it's reviews" do
      user = User.create! :user_name => 'John Doe', :email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
      restaurant = Restaurant.create!(name: "Nandos", description: "Cheeky", user_id: user.id)
      restaurant.reviews.create(thoughts: "Bad", rating: 1)
      expect(restaurant.rating).to eq 1
    end
  end
end
