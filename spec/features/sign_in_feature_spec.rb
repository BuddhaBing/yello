require 'rails_helper'

feature 'sign in' do
  context 'signing in to website' do
    scenario 'user can sign in to website after creating account' do
      sign_up
      click_link 'Logout'
      log_in
      expect(page).to have_content 'Signed in successfully'
    end
  end
  context 'signing out' do
    scenario 'user can sign out of website' do
      sign_up
      click_link 'Logout'
      click_link 'Log In'
      expect(page).not_to have_content 'You are already signed in'
    end
  end
end
