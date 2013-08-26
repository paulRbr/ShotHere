class MovieGenreInfo < ActiveRecord::Base

  belongs_to :movie
  belongs_to :genre

  attr_accessible :comment, :genre_id, :movie_id
end
