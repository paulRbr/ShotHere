class MovieDirectorInfo < ActiveRecord::Base

  belongs_to :movie
  belongs_to :director

  attr_accessible :comment, :director_id, :movie_id
end
