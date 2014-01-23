class MovieLocationInfo < ActiveRecord::Base

  belongs_to :movie
  belongs_to :location

end
