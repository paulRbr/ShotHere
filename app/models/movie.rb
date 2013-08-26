require 'net/http'
require 'uri'
require 'json'


class Movie < ActiveRecord::Base

  has_many :movie_location_infos
  has_many :locations, :through => :movie_location_infos

  has_many :movie_director_infos
  has_many :directors, :through => :movie_director_infos

  has_many :movie_genre_infos
  has_many :genres, :through => :movie_genre_infos

  attr_accessible :imdb_id, :title, :id, :updated_at, :created_at, :poster, :imdb_url, :year, :rating

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
    self[:imdb_id] = an_id
    data = get_imdb_data an_id
    %w(title imdb_url poster year rating).each do |attr|
      self[attr] = "#{data[attr]}" unless data[attr].nil? or data[attr].respond_to?(:keys)
    end
    %w(directors genres).each do |attr|
      self.send("set_#{attr}", data[attr])
    end
    find_main_location data["filming_locations"]
  rescue => e
    errors.add :imdb_id, e.message
    Rails.logger.warn e
  end

  private

  def find_main_location(location_name)
    return if location_name.nil?
    location = Location.where(address: location_name).first_or_create
    locations << location
  end

  def set_directors(directors_name)
    return if directors_name.nil?
    directors_name.each do |director_name|
      director = Director.where(name: director_name).first_or_create
      directors << director
    end
  end

  def set_genres(genres_name)
    return if genres_name.nil?
    genres_name.each do |genre_name|
      genre = Genre.where(name: genre_name).first_or_create
      genres << genre
    end
  end

  def get_imdb_data(imdb_id)
    Rails.logger.debug imdb_id
    uri = URI.parse("http://mymovieapi.com/?ids=tt#{imdb_id}&type=json")
    response = Net::HTTP.get_response(uri)
    Rails.logger.debug response.body
    begin
      data = JSON.parse(response.body)
    rescue => e
      Rails.logger.warn "Bad response from mymovieapi: #{e}"
      data = nil
    end
    if data.nil?
      raise "Unable to use mymovieapi.com"
    elsif !data.kind_of?(Array) and data["error"]
      raise data["error"]
    elsif data.kind_of?(Array) and data.empty?
      raise "No result found"
    end
    movie = data.first
    movie['poster'] = movie['poster']['imdb'] unless movie['poster'].nil?
    Rails.logger.debug movie['poster']
    movie
  end

end
