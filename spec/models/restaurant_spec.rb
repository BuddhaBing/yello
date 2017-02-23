require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it "is not valid with a name of less than 3 chars" do
    restaurant = Restaurant.new(name:"na", user_id: 1)
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    user = User.create! :user_name => 'John Doe', :email => 'john@example.com', :password => 'topsecret', :password_confirmation => 'topsecret'
    Restaurant.create!(name: "Nandos", description: "Cheeky", user_id: user.id)
    restaurant = Restaurant.new(name: "Nandos", description: "Cheeky", user_id: user.id)
    expect(restaurant).to have(1).error_on(:name)
  end

  describe "#rating" do
    it "returns a doubled average rating from it's reviews" do
      user = User.create! :user_name => 'John Doe', :email => 'john@example.com', :password => 'topsecret', :password_confirmation => 'topsecret'
      user2 = User.create! :user_name => 'Jane Doe', :email => 'jane@example.com', :password => 'topsecret', :password_confirmation => 'topsecret'
      restaurant = Restaurant.create!(name: "Nandos", description: "Cheeky", user_id: user.id)
      restaurant.reviews.create(thoughts: "Bad", rating: 1, user_id: user2.id)
      expect(restaurant.rating).to eq 2
    end
    it "returns a doubled average rating of 8 from 2 reviews (3 and 5)" do
      user = User.create! :user_name => 'John Doe', :email => 'john@example.com', :password => 'topsecret', :password_confirmation => 'topsecret'
      user2 = User.create! :user_name => 'Jane Doe', :email => 'jane@example.com', :password => 'topsecret', :password_confirmation => 'topsecret'
      user3 = User.create! :user_name => 'Paul Doe', :email => 'paul@example.com', :password => 'topsecret', :password_confirmation => 'topsecret'
      restaurant = Restaurant.create!(name: "Nandos", description: "Cheeky", user_id: user.id)
      restaurant.reviews.create(thoughts: "Bad", rating: 3, user_id: user2.id)
      restaurant.reviews.create(thoughts: "Bad", rating: 5, user_id: user3.id)
      expect(restaurant.rating).to eq 8
    end
    it "returns a doubled average rating from it's reviews of 7 from 3 reviews (3, 5 and 3)" do
      user = User.create! :user_name => 'John Doe', :email => 'john@example.com', :password => 'topsecret', :password_confirmation => 'topsecret'
      user2 = User.create! :user_name => 'Jane Doe', :email => 'jane@example.com', :password => 'topsecret', :password_confirmation => 'topsecret'
      user3 = User.create! :user_name => 'Paul Doe', :email => 'paul@example.com', :password => 'topsecret', :password_confirmation => 'topsecret'
      user4 = User.create! :user_name => 'Simon Doe', :email => 'simon@example.com', :password => 'topsecret', :password_confirmation => 'topsecret'
      restaurant = Restaurant.create!(name: "Nandos", description: "Cheeky", user_id: user.id)
      restaurant.reviews.create(thoughts: "Bad", rating: 3, user_id: user2.id)
      restaurant.reviews.create(thoughts: "Bad", rating: 5, user_id: user3.id)
      restaurant.reviews.create(thoughts: "Bad", rating: 3, user_id: user4.id)
      expect(restaurant.rating).to eq 7
    end
  end
end
