def sign_up(name:"joe", email: 'joe@example.com', password: 'shoobydooby')
  visit '/'
  click_link 'Sign Up'
  fill_in 'user_user_name', with: name
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  fill_in 'user_password_confirmation', with: password
  click_button 'Sign up'
end

def log_in
  visit '/'
  click_link 'Log In'
  fill_in 'user_email', with: 'joe@example.com'
  fill_in 'user_password', with: 'shoobydooby'
  click_button 'Log in'
end

def sign_out
  visit '/'
  click_link 'Logout'
end
