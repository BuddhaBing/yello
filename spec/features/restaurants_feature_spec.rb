require 'rails_helper'

feature 'restaurants' do

  scenario 'should display a prompt to add a restaurant if the user is logged in' do
    sign_up
    visit '/restaurants'
    expect(page).to have_content 'No restaurants yet'
    expect(page).to have_link 'Add a restaurant'
  end



  scenario 'display restuarants' do
    sign_up
    create_restaurant
    visit '/restaurants'
    expect(page).to have_content('Nandos')
    expect(page).not_to have_content('No restaurants yet')
  end


  scenario 'removes a resturant when a user clicks a delete link' do
    sign_up
    create_restaurant
    click_link 'Delete Nandos'
    expect(page).not_to have_content 'Nandos'
    expect(page).to have_content 'Restaurant deleted successfully'
    expect(current_path).to eq '/restaurants'
  end




  scenario 'prompts user to fill out a form, then displays the new restaurant' do
    sign_up
    create_restaurant
    expect(page).to have_content "Nandos"
    expect(current_path).to eq "/restaurants"
  end

  context "an invalid restaurant" do
    scenario 'does not let you submit a name that is too short' do
      sign_up
      create_restaurant(name: "Na")
      expect(page).not_to have_css 'h2', text: 'na'
      expect(page).to have_content 'error'
    end
  end





  scenario 'lets a user view a restaurant' do
    sign_up
    create_restaurant
    visit '/restaurants'
    click_link 'Nandos'
    expect(page).to have_content 'Nandos'
    expect(current_path).to eq "/restaurants/#{Restaurant.first.id}"
  end



  scenario 'let a user edit a restaurant' do
    sign_up
    create_restaurant
    edit_restaurant
    expect(page).to have_content 'Nandos'
    expect(page).to have_content 'Cheeky chicken'
    expect(current_path).to eq "/restaurants/#{Restaurant.first.id}"
  end
  scenario 'cannot create a restaurant if not logged in' do
    visit '/'
    expect(page).not_to have_link('Add a restaurant')
  end

  context "an invalid restaurant" do
    scenario 'does not let you submit a name that is too short' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'na'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'na'
      expect(page).to have_content 'error'
    end
  end

  scenario 'lets a user view a restaurant' do
    sign_up
    create_restaurant
    visit '/restaurants'
    click_link 'Nandos'
    expect(page).to have_content 'Nandos'
    expect(current_path).to eq "/restaurants/#{Restaurant.first.id}"
  end
end
