require 'rails_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    sign_up
    create_restaurant
    sign_out
    sign_up_other_user
    add_review
    expect(page).to have_content('so so')
  end

  scenario 'user cannot review their own restaurant' do
    sign_up
    create_restaurant
    visit '/restaurants'
    expect(page).not_to have_link("Review Nandos")
  end

  scenario 'user can only review each restaurant once' do
    sign_up
    create_restaurant
    sign_out
    sign_up_other_user
    add_review
    expect{add_review}.not_to change{Review.all.length}
    expect(page).to have_content "You've already reviewed this restaurant"
  end

  scenario 'user can only review resturants when logged on' do
    sign_up
    create_restaurant
    sign_out
    expect(page).not_to have_content "Review Nandos"
  end
end
