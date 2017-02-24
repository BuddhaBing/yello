module RestaurantsHelper

  def owner?(restaurant)
    user_signed_in? ? restaurant.user_id == current_user.id : false
  end

  def gmapsurl(restaurant)
    "https://www.google.com/maps/embed/v1/place?key=AIzaSyBvvkMB4nKreiEoe4uG5hFBoTvo5w3toAY&q=#{(restaurant.latitude.to_s) + "," + (restaurant.longitude.to_s)}"
  end
end
