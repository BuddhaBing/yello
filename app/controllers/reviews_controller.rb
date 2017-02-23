class ReviewsController < ApplicationController
  def new
    if !user_signed_in?
      redirect_to "/"
      flash[:notice] = 'you can\'t review when not logged in you naughty person'
    end
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
    @restaurant.reviews.new(review_params.merge(:user_id => current_user.id))
    if @restaurant.save
      redirect_to "/restaurants/#{@restaurant.id}"
    else
      flash[:notice] = 'You\'ve already reviewed this restaurant'
      redirect_to "/restaurants/#{@restaurant.id}/reviews/new"
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
