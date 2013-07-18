require 'net/http'
require 'uri'
require 'json'

class Movie < ActiveRecord::Base
  attr_accessible :imdb_id, :title, :id, :updated_at, :created_at, :location, :poster, :imdb_url
  attr_accessible :latitude, :longitude

  geocoded_by :location
  validates_presence_of :imdb_id
  validates_uniqueness_of :imdb_id
  before_validation :populate_from_imdb, :only => [:imdb_id]

  def populate_from_imdb
    uri = URI.parse("http://mymovieapi.com/?id=tt#{self.imdb_id}&type=json")
    response = Net::HTTP.get_response(uri)
    Rails.logger.debug response.body
    begin
      data = JSON.parse(response.body)
    rescue JSON::ParseError
      data = nil
    end
    if data.nil?
      errors.add(:imdb_id, "unable to use mymovieapi.com")
    else
      unless data["error"]
        self.title = data["title"] if data["title"]
        self.poster = data["poster"] if data["poster"]   
        self.imdb_url = data["imdb_url"] if data["imdb_url"]  
        self.location = data["filming_locations"] if data["filming_locations"]
        while self.location.present? and not self.latitude? and not self.longitude?
          geocode
          self.location = self.location.split(',')[1..-1].join(',') unless self.latitude?
          Rails.logger.debug "#{self.location} geocoded: #{self.latitude}, #{self.longitude}" if self.latitude?
        end
        self.location = data["filming_locations"] if data["filming_locations"]
      else
        errors.add(:imdb_id, "doesn't represent any movie on imdb")
      end
    end
    errors.empty?
  end

end
