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

  end

  scenario 'cannot create a restaurant if not logged in' do
    visit '/'
    expect(page).not_to have_link('Add a restaurant')
  end

  scenario 'can view average star rating for restaurants' do
    sign_up
    create_restaurant
    sign_out
    sign_up(name:"john", email: 'john@example.com', password: 'shoobydooby')
    add_review(3)
    sign_out
    sign_up(name:"paul", email: 'paul@example.com', password: 'shoobydooby')
    add_review(5)
    visit '/'
    expect(page.find_by_id("restaurant-#{Restaurant.first.id}-rating")).to have_content("★★★★")
  end

end
