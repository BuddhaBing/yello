class ReviewsController < ApplicationController
  def new
    # @owner = Restaurant.all(user_id: current_user.id)

    @restaurant = Restaurant.find(params[:restaurant_id])
    p @restaurant
    @owner = @restaurant.user_id
    p @owner
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(review_params)
    redirect_to "/restaurants/#{@restaurant.id}"
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
