require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been updated' do
    scenario 'should display a prompt to add a restaurant if the user is logged in' do
      sign_up
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end
  context 'restaurants have been added' do
    scenario 'display restuarants' do
      sign_up
      add_restaurant
      visit '/restaurants'
      expect(page).to have_content('Nandos')
      expect(page).not_to have_content('No restaurants yet')
    end
  end
  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: "Nandos"
      click_button 'Create Restaurant'
      expect(page).to have_content "Nandos"
      expect(current_path).to eq "/restaurants"
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
  end
  context 'viewing restaurants' do
    scenario 'lets a user view a restaurant' do
      sign_up
      add_restaurant
      visit '/restaurants'
      click_link 'Nandos'
      expect(page).to have_content 'Nandos'
      expect(current_path).to eq "/restaurants/#{Restaurant.first.id}"
    end
  end
  context 'editing restaurants' do
    scenario 'let a user edit a restaurant' do
      sign_up
      add_restaurant
      visit '/restaurants'
      click_link 'Edit Nandos'
      fill_in 'Name', with: 'Nandos'
      fill_in 'Description', with: 'Cheeky chicken'
      click_button 'Update Restaurant'
      click_link 'Nandos'
      expect(page).to have_content 'Nandos'
      expect(page).to have_content 'Cheeky chicken'
    end
  end
  context 'deleting restaurants' do
    scenario 'removes a resturant when a user clicks a delete link' do
      sign_up
      add_restaurant
      visit '/restaurants'
      click_link 'Delete Nandos'
      expect(page).not_to have_content 'Nandos'
      expect(page).to have_content 'Restaurant deleted successfully'
      expect(current_path).to eq '/restaurants'
    end
  end
end
