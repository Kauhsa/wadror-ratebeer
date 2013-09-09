class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @beers = Beer.all
    @rating = Rating.new
  end

  def create
    rating = Rating.create params[:rating]
    current_user.ratings << rating    
    redirect_to user_path current_user
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete
    redirect_to :back
  end

end