def add_review
  visit '/restaurants'
  click_link 'Review Nandos'
  fill_in "Thoughts", with: "so so"
  select '3', from: 'Rating'
  click_button 'Leave Review'
end
