def add_review(score=3)
  visit '/restaurants'
  click_link 'Review Nandos'
  fill_in "Thoughts", with: "so so"
  select score, from: 'Rating'
  click_button 'Leave Review'
end

def edit_review(score=5)
  visit "/restaurants/#{Restaurant.first.id}"
  click_link 'Edit review'
  fill_in "Thoughts", with: "Updated review: Awesome!"
  select score, from: 'Rating'
  click_button 'Edit review'
end
