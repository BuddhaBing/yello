require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'Nandos', id: 30 }
  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Nandos'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants/30'
    expect(page).to have_content('so so')
  end
  scenario 'user cannot review their own restaurant' do
    sign_up
    add_restaurant
    visit '/restaurants'
    click_link 'Review Nandos'
    expect(page).to have_content("You cannot review your own restaurant")
  end
end
