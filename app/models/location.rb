class Location < ActiveRecord::Base

  has_many :movie_location_infos
  has_many :movies, :through => :movie_location_infos

  attr_accessible :address, :comment, :latitude, :longitude
  geocoded_by :address

  after_validation :fine_tune_location

  def fine_tune_location
    initial_address = self.address
    unless self.address.nil?
      Rails.logger.debug "Geocoding #{self.address}..."
      self.geocode
      begin
        self.address = self.address.split(',')[1..-1].join(',')
        Rails.logger.debug "Geocoding #{self.address}..."
        self.geocode
      end until self.geocoded? or self.address.empty?
      Rails.logger.debug "#{self.address} geocoded as: [#{self.latitude}, #{self.longitude}]" if self.geocoded?
    end
    unless self.geocoded?
      Rails.logger.warn "Cannot geocode at all. Restoring initial data."
      self.address = initial_address
    end
    true
   end

end