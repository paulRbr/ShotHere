class DirectorsController < ApplicationController
  
  before_filter :load_movie

  # GET /movies/:movie_id/directors
  def index
    @directors = @movie.directors

    respond_to do |format|
      format.json { render json: @directors }
    end
  end

  private

  def load_movie
    @movie = Movie.find(params[:movie_id])
  end
end
