def create_restaurant(name: "Nandos",
                      description: "Cheeky",
                      phone_number: "",
                      location: "")
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: name
  fill_in 'Description', with: description
  fill_in 'Telephone', with: phone_number
  fill_in 'Address', with:  location
  click_button 'Create Restaurant'
end

def edit_restaurant(name: "Nandos", description: "Cheeky chicken")
  visit '/restaurants'
  click_link 'Edit Nandos'
  fill_in 'Name', with: name
  fill_in 'Description', with: description
  click_button 'Update Restaurant'
  click_link name
end
