require 'net/http'
require 'uri'
require 'json'


class Movie < ActiveRecord::Base

  has_many :movie_location_infos
  has_many :locations, :through => :movie_location_infos

  attr_accessible :imdb_id, :title, :id, :updated_at, :created_at, :poster, :imdb_url

  validates_presence_of :imdb_id
  validates_uniqueness_of :imdb_id



  def self.create_imdb_movie(imdb_id_or_url_or_array)
    if imdb_id_or_url_or_array.is_a? Array
      imdb_id_or_url_or_array.each { |imdb_id_or_url| create_imdb_movie imdb_id_or_url }
    end
    imdb_id_or_url = imdb_id_or_url_or_array
    imdb_id = imdb_id_or_url.to_s.gsub(/\D/, "")

    data = get_imdb_data imdb_id
    movie = new ({:imdb_id => imdb_id})
    puts "Brand new: #{movie.inspect}"
    %w(title poster imdb_url).each {
        |attr| movie[attr] = "#{data[attr]}" unless data[attr].nil?
    }
    puts "Imdb Data added: #{movie.inspect}"
    find_main_location movie, data["filming_locations"]
    movie.locations.each {|loc| puts loc.inspect }
    movie.save
    movie
  end

  private

  def self.find_main_location(movie, location_name)
    return if location_name.nil?
    location = Location.new({:address => location_name})
    movie.locations << location
  rescue => e
    movie.errors.add :locations, e.message
    Rails.logger.warn e
  end

  def self.get_imdb_data(imdb_id)
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
      raise "Unable to use mymovieapi.com"
    end
    data
  end

end
