require 'rails_helper'

feature 'reviewing' do
  scenario 'allows users to leave a review using a form' do
    sign_up
    create_restaurant
    sign_out
    sign_up(name: "billy", email: 'billy@example.com')
    add_review
    expect(page).to have_content('so so')
  end
  scenario 'user cannot review their own restaurant' do
    sign_up
    create_restaurant
    visit '/restaurants'
    expect(page).not_to have_link("Review Nandos")
  end
end
