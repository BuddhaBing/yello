# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Review.delete_all
Restaurant.delete_all
User.delete_all

user1 = User.create! :user_name => 'John Doe', :email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
user2 = User.create! :user_name => 'Ivan Drago', :email => 'ivan@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
user3 = User.create! :user_name => 'Rocky', :email => 'rocky@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'

Restaurant.create!(name: "Nandos", description: "Cheeky", user_id: user1.id)
Restaurant.create!(name: "KFC", description: "Dirty", user_id: user2.id)
Restaurant.create!(name: "Wimpy", description: "Filthy", user_id: user3.id)

Review.create!(thoughts: "nasty" , rating: 1, restaurant_id: Restaurant.find_by(name: 'Nandos').id)
Review.create!(thoughts: "smelly", rating: 4, restaurant_id: Restaurant.find_by(name: 'Nandos').id)
Review.create!(thoughts: "wut"   , rating: 3, restaurant_id: Restaurant.find_by(name: 'Wimpy').id)
