class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if owner?(@restaurant)
      redirect_to '/restaurants'
      flash[:notice] = "You can't review your own restaurant"
    else
      @review = Review.new
    end
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
