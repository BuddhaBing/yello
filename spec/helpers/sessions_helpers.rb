def sign_up
  visit '/'
  click_link 'Sign Up'
  fill_in 'user_email', with: 'joe@example.com'
  fill_in 'user_password', with: 'shoobydooby'
  fill_in 'user_password_confirmation', with: 'shoobydooby'
  click_button 'Sign up'
end
