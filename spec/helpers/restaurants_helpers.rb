def create_restaurant(name: "Nandos", description: "Cheeky")
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: name
  fill_in 'Description', with: description
  click_button 'Create Restaurant'
end