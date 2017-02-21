require 'rails_helper'

feature 'sign up' do
  context 'signing up to website' do
    scenario 'user can sign up to website' do
      expect{sign_up}.to change{User.count}.by(1)
      expect(User.first.email).to eq('joe@example.com')
    end
  end
end
