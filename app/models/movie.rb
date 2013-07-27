require 'net/http'
require 'uri'
require 'json'


module ImdbSearch

  def self.search

  end

end



class Movie < ActiveRecord::Base

  has_many :movie_location_infos
  has_many :locations, :through => :movie_location_infos

  attr_accessible :imdb_id, :title, :id, :updated_at, :created_at, :poster, :imdb_url

  validates_presence_of :imdb_id
  validates_uniqueness_of :imdb_id
#  before_validation :populate_from_imdb, :only => [:imdb_id]



  def self.create_imdb_movie(imdb_id_or_url)
    imdb_id = imdb_id_or_url.to_s.gsub(/\D/, "")
    Rails.logger.debug imdb_id
    uri = URI.parse("http://mymovieapi.com/?id=tt#{imdb_id}&type=json")
    response = Net::HTTP.get_response(uri)
    Rails.logger.debug response.body
    begin
      data = JSON.parse(response.body)
    rescue JSON::ParseError
      data = nil
    end
    if data.nil?
      raise "unable to use mymovieapi.com"
    else
      movie = new
      %w(title poster imdb_url).each { |attribute| movie.attributes[attribute] = data[attribute] }
      if data["filming_locations"]
        begin
          location = Location.new({:address => data["filming_locations"]})
          movie.locations << location
          location.save
        rescue => e
          movie.errors.add :locations, e.message
          Rails.logger.warn e
        end
      end
      movie.save
    end
    movie
  end

  #
  #
  #
  #def populate_from_imdb
  #  parse_imdb_id
  #  Rails.logger.debug self.imdb_id
  #  uri = URI.parse("http://mymovieapi.com/?id=tt#{self.imdb_id}&type=json")
  #  response = Net::HTTP.get_response(uri)
  #  Rails.logger.debug response.body
  #  begin
  #    data = JSON.parse(response.body)
  #  rescue JSON::ParseError
  #    data = nil
  #  end
  #  if data.nil?
  #    errors.add(:imdb_id, "unable to use mymovieapi.com")
  #  else
  #    unless data["error"]
  #      self.title = data["title"] if data["title"]
  #      self.poster = data["poster"] if data["poster"]
  #      self.imdb_url = data["imdb_url"] if data["imdb_url"]
  #      self.location = data["filming_locations"] if data["filming_locations"]
  #      while self.location.present? and not self.latitude? and not self.longitude?
  #        geocode
  #        self.location = self.location.split(',')[1..-1].join(',') unless self.latitude?
  #        Rails.logger.debug "#{self.location} geocoded: #{self.latitude}, #{self.longitude}" if self.latitude?
  #      end
  #      self.location = data["filming_locations"] if data["filming_locations"]
  #    else
  #      errors.add(:imdb_id, "doesn't represent any movie on imdb")
  #    end
  #  end
  #  errors.empty?
  #end
  #
  #
  #def parse_imdb_id
  #  self.imdb_id = self.imdb_id.to_s.gsub(/\D/, "")
  #end
  #

end
