class LocationsController < ApplicationController
  
  before_filter :load_movie

  # GET /movies/:movie_id/locations
  def index
    @locations = @movie.locations

    respond_to do |format|
      format.json { render json: @locations }
    end
  end

  private

  def load_movie
    @movie = Movie.find(params[:movie_id])
  end
end
