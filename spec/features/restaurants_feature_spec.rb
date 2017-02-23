require 'rails_helper'

feature 'restaurants' do

  context 'logged in' do
    before (:each) do
      sign_up
    end

    scenario 'should display a prompt to add a restaurant if the user is logged in' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      create_restaurant
      expect(page).to have_content "Nandos"
      expect(current_path).to eq "/restaurants"
    end

    scenario 'does not let you submit a name that is too short' do
      create_restaurant(name: "Na")
      expect(page).not_to have_css 'h2', text: 'na'
      expect(page).to have_content 'error'
    end
  end

  context ' single resturant exists and user is owner ' do
    before (:each) do
      sign_up
      create_restaurant
    end

    scenario 'display restuarants' do
      visit '/restaurants'
      expect(page).to have_content('Nandos')
      expect(page).not_to have_content('No restaurants yet')
    end

    scenario 'removes a resturant when a user clicks a delete link' do
      click_link 'Delete Nandos'
      expect(page).not_to have_content 'Nandos'
      expect(page).to have_content 'Restaurant deleted successfully'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Nandos'
      expect(page).to have_content 'Nandos'
      expect(current_path).to eq "/restaurants/#{Restaurant.first.id}"
    end

    scenario 'let a user edit a restaurant' do
      edit_restaurant
      expect(page).to have_content 'Nandos'
      expect(page).to have_content 'Cheeky chicken'
      expect(current_path).to eq "/restaurants/#{Restaurant.first.id}"
    end

    context 'editing/deleting restaurants' do
      before (:each)do
        sign_out
        sign_up(name: 'Jim', email: 'jim@example.com')
      end

      scenario 'users can only see edit links for restaurants they own' do
        expect(page).not_to have_link "Edit Nandos"
      end

      scenario "users are redirected if they try to visist edit url for restaurants they don't own" do
        visit "/restaurants/#{Restaurant.first.id}/edit"
        expect(current_path).to eq '/restaurants'
        expect(page).to have_content 'You can only edit restaurants you own'
      end

      scenario "users can only see delete links for restaurants they own" do
        expect(page).not_to have_link "Delete Nandos"
      end
    end
  end

  scenario 'cannot create a restaurant if not logged in' do
    visit '/'
    expect(page).not_to have_link('Add a restaurant')
  end
end
