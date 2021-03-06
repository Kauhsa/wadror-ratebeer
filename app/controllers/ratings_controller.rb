class RatingsController < ApplicationController
  before_filter :ensure_that_signed_in, :except => [:index]

  def index
    return if fragment_exist? 'ratings_cache'

    @ratings = Rating.all
    @recent_ratings = Rating.recent
    @top_beers = Beer.top 3
    @top_breweries = Brewery.top 3
    @top_styles = Style.top 3
    @active_users = User.all.sort_by{|x| -x.ratings.count}.first(3)
  end

  def new
    @beers = Beer.all
    @rating = Rating.new
  end

  def create
    @rating = Rating.new params[:rating]

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end