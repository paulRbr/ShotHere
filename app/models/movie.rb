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
      imdb_id_or_url_or_array.map { |imdb_id_or_url| create_imdb_movie imdb_id_or_url }
      return imdb_id_or_url_or_array
    end
    imdb_id_or_url = imdb_id_or_url_or_array

    movie = new ({:imdb_id => imdb_id_or_url})
    movie.save
    movie
  end

  def imdb_id=(imdb_id_or_url)
    an_id = imdb_id_or_url.to_s.gsub(/\D/, "")
    data = get_imdb_data an_id
    self[:imdb_id] = an_id
    Rails.logger.debug data
    %w(title poster imdb_url).each { |attr| self[attr] = "#{data[attr]}" unless data[attr].nil? }
    find_main_location data["filming_locations"]
  rescue => e
    errors.add :imdb_id, e.message
    Rails.logger.warn e
  end

  private

  def find_main_location(location_name)
    return if location_name.nil?
    location = Location.new({:address => location_name})
    locations << location
  end

  def get_imdb_data(imdb_id)
    Rails.logger.debug imdb_id
    uri = URI.parse("http://mymovieapi.com/?ids=tt#{imdb_id}&type=json")
    response = Net::HTTP.get_response(uri)
    Rails.logger.debug response.body
    begin
      data = JSON.parse(response.body)
    rescue JSON::ParseError
      data = nil
    end
    if data.nil?
      raise "Unable to use mymovieapi.com"
    elsif !data.kind_of?(Array) and data["error"]
      raise data["error"]
    elsif data.kind_of?(Array) and data.empty?
      raise "No result found"
    end
    data.first
  end

end
