class ApplicationController < ActionController::Base
  protect_from_forgery

  # GET /
  def empty_index
    latest_movies = Movie.last(3)
    box_office_movies = Movie.where.not(box_office: nil)

    @startup_data = {
      week_number: Time.now.strftime('%V'),
      movies_count: Movie.count,
      movies: latest_movies+box_office_movies
    }

    respond_to do |format|
      format.html { render :index } # index.html.haml
    end
  end
end
