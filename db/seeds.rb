# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all

User.create! :user_name => 'John Doe', :email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
User.create! :user_name => 'Ivan Drago', :email => 'ivan@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
User.create! :user_name => 'Rocky', :email => 'rocky@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'

Restaurant.delete_all

Restaurant.create!(name: "Nandos", description: "Cheeky")
Restaurant.create!(name: "KFC", description: "Dirty")
Restaurant.create!(name: "Wimpy", description: "Filthy")
