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

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    if !owner?(@restaurant)
      redirect_to '/restaurants'
      flash[:notice] = "You can only edit reviews that you wrote"
    end
    @review = @restaurant.reviews.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to '/restaurants'
    flash[:notice] = 'Review edited successfully'
  end

  def destroy
    restaurant = Restaurant.find(params[:restaurant_id])
    review = restaurant.reviews.find(params[:id])
    review.destroy
    flash[:notice] = 'Review deleted successfully'
    redirect_to '/restaurants'
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
