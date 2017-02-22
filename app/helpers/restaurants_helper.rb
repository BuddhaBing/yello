module RestaurantsHelper

  def owner?(restaurant)
    user_signed_in? ? restaurant.user_id == current_user.id : false
  end
end
