class MovieLocationInfo < ActiveRecord::Base

  belongs_to :movie
  belongs_to :location

  attr_accessible :comment, :location_id, :movie_id
end
