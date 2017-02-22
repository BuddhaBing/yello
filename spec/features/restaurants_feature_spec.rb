require 'rails_helper'

feature 'restaurants' do
  
  context 'no restaurants have been updated' do
    scenario 'should display a prompt to add a restaurant' do
      visit 'restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end
  
  context 'restaurants have been added' do
    
    before do
      create_restaurant
    end
    
    scenario 'display restuarants' do
      visit '/restaurants'
      expect(page).to have_content('Nandos')
      expect(page).not_to have_content('No restaurants yet')
    end
    
    context 'deleting restuarants' do
      scenario 'removes a resturant when a user clicks a delete link' do
        click_link 'Delete Nandos'
        expect(page).not_to have_content 'Nandos'
        expect(page).to have_content 'Restaurant deleted successfully'
        expect(current_path).to eq '/restaurants'
      end
    end
  end
  
  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      create_restaurant
      expect(page).to have_content "Nandos"
      expect(current_path).to eq "/restaurants"
    end
    
    context "an invalid restaurant" do
      scenario 'does not let you submit a name that is too short' do
        create_restaurant(name: "Na")
        expect(page).not_to have_css 'h2', text: 'na'
        expect(page).to have_content 'error'
      end
    end
  end
  
  context "Nando's has been created" do
    
    let!(:nandos) { Restaurant.create(name: "Nandos") }
    
    context 'viewing restaurants' do
      scenario 'lets a user view a restaurant' do
        visit '/restaurants'
        click_link 'Nandos'
        expect(page).to have_content 'Nandos'
        expect(current_path).to eq "/restaurants/#{nandos.id}"
      end
    end
    
    context 'editing restaurants' do
      scenario 'let a user edit a restaurant' do
        edit_restaurant
        expect(page).to have_content 'Nandos'
        expect(page).to have_content 'Cheeky chicken'
        expect(current_path).to eq "/restaurants/#{nandos.id}"
      end
    end
  end
end
