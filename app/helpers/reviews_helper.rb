module ReviewsHelper

  def star_icons(number)
    star = "★"
    half_star = "½"
    return star * 3 if number == 0
    return star * (number / 2) if number % 2 == 0
    return star * (number / 2).floor + half_star
  end

  def reviewer?(review)
    user_signed_in? ? review.user_id == current_user.id : false
  end

  def reviewer_name(review)
    User.find(review.user_id).user_name
  end

  # def star_icons(number)
  #   star = "i class='fa fa-star-o' aria-hidden='true'"
  #   half_star = "i class='fa fa-star-half-o' aria-hidden='true'"
  #   return star * (number / 2) if number % 2 == 0
  #   return star * (number / 2).floor + half_star
  # end
end
