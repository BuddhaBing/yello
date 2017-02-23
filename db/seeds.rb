Restaurant.delete_all
Review.delete_all
User.delete_all

user1 = User.create user_name: 'John Doe'  , email: 'john@example.com',  password: 'topsecret', password_confirmation: 'topsecret'
user2 = User.create user_name: 'Ivan Drago', email: 'ivan@example.com',  password: 'topsecret', password_confirmation: 'topsecret'
user3 = User.create user_name: 'Rocky'     , email: 'rocky@example.com', password: 'topsecret', password_confirmation: 'topsecret'

restaurant1 = Restaurant.create(name: "Nandos", description: "Cheeky", user_id: user1.id)
restaurant2 = Restaurant.create(name: "KFC",    description: "Dirty",  user_id: user1.id)
restaurant3 = Restaurant.create(name: "Wimpy",  description: "Filthy", user_id: user3.id)

Review.create(thoughts: "nasty" , rating: 1, restaurant_id: restaurant1.id, user_id: user2.id)
Review.create(thoughts: "smelly", rating: 4, restaurant_id: restaurant2.id, user_id: user2.id)
Review.create(thoughts: "wut"   , rating: 3, restaurant_id: restaurant3.id, user_id: user2.id)
