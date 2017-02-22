def add_restaurant
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: "Nandos"
  click_button 'Create Restaurant'
end

def add_another_restaurant
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: "KFC"
  click_button 'Create Restaurant'
end
