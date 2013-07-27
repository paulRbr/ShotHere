class Location < ActiveRecord::Base

  has_many :movie_location_infos
  has_many :movies, :through => :movie_location_infos

  attr_accessible :address, :comment, :latitude, :longitude
  geocoded_by :address
  after_validation :geocode, :if => lambda{ |obj| obj.address_changed? }


end
