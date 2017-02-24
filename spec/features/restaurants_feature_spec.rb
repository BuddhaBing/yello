require 'rails_helper'

feature 'restaurants' do

  context 'logged in' do
    before (:each) do
      sign_up
    end

    scenario 'can add phone number to resturant' do
      visit '/restaurants'
      create_restaurant(phone_number: "01632-960000")
      click_link 'Nandos'
      expect(page).to have_content 'phone number: 01632960000'
    end

    scenario 'can add location to resturants via google maps' do
      visit '/restaurants'
      create_restaurant(location: "buckingham palace")
      click_link 'Nandos'
      expect(Restaurant.first.latitude).to be(51.5023131)
      expect(page).to have_content 'Constitution Hill, London SW1A 1AA'
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

  context 'viewing average rating' do

    before(:each) do
      sign_up
      create_restaurant
      sign_out
      sign_up(name:"john", email: 'john@example.com', password: 'shoobydooby')
      add_review(3)
      sign_out
      sign_up(name:"paul", email: 'paul@example.com', password: 'shoobydooby')
      add_review(5)
    end

    scenario 'can view average star rating for all reviewed restaurants' do
      visit '/'
      expect(page.find_by_id("restaurant-#{Restaurant.first.id}-rating")).to have_content("★★★★")
    end

    scenario 'can view average star rating for an individual restaurant' do
      visit "/restaurants/#{Restaurant.first.id}"
      expect(page.find_by_id("restaurant-#{Restaurant.first.id}-rating")).to have_content("★★★★")
    end

  end

end
