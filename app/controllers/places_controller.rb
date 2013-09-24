class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingAPI.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, :notice => "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @place = BeermappingAPI.place(params[:city], params[:id])
    @scores = BeermappingAPI.scores_in(@place.id)
    unless @place
      redirect_to :back, :notice => "Place not found"
    else
      render :show
    end
  end
end