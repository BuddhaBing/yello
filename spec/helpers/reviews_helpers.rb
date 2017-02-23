def add_review(score=3)
  visit '/restaurants'
  click_link 'Review Nandos'
  fill_in "Thoughts", with: "so so"
  select score, from: 'Rating'
  click_button 'Leave Review'
end
