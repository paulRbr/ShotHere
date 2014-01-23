class MovieDirectorInfo < ActiveRecord::Base

  belongs_to :movie
  belongs_to :director

end
