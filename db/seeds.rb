# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create user_name: 'John Doe'  , email: 'john@example.com',  password: 'topsecret', password_confirmation: 'topsecret'
User.create user_name: 'Ivan Drago', email: 'ivan@example.com',  password: 'topsecret', password_confirmation: 'topsecret'
User.create user_name: 'Rocky'     , email: 'rocky@example.com', password: 'topsecret', password_confirmation: 'topsecret'

Restaurant.create(name: "Nandos", description: "Cheeky")
Restaurant.create(name: "KFC",    description: "Dirty")
Restaurant.create(name: "Wimpy",  description: "Filthy")

Review.create(thoughts: "nasty" , rating: 1, restaurant_id: Restaurant.find_by(name: 'Nandos').id)
Review.create(thoughts: "smelly", rating: 4, restaurant_id: Restaurant.find_by(name: 'Nandos').id)
Review.create(thoughts: "wut"   , rating: 3, restaurant_id: Restaurant.find_by(name: 'Wimpy').id)
