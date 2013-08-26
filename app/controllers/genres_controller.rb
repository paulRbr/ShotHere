class GenresController < ApplicationController
  
  before_filter :load_movie

  # GET /movies/:movie_id/genres
  def index
    @genres = @movie.genres

    respond_to do |format|
      format.json { render json: @genres }
    end
  end

  private

  def load_movie
    @movie = Movie.find(params[:movie_id])
  end
end
