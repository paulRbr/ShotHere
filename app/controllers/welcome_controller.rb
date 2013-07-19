class WelcomeController < ApplicationController
  def index
    @movies = Movie.all
    @center = Geocoder::Calculations.geographic_center @movies
  end
end
