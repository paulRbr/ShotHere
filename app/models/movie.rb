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

  validates_presence_of :imdb_id
  validates_uniqueness_of :imdb_id

  # For the pagination (will_paginate gem)
  self.per_page = 100

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
    m = Imdb::Movie.new(an_id)
    self[:imdb_url] = m.url
    %w(title poster year rating).each do |attr|
      self[attr] = m.send :"#{attr}" unless m.send(:"#{attr}").nil? or m.send(:"#{attr}").respond_to?(:keys)
    end
    set_directors(m.director)
    %w(genres filming_locations).each do |attr|
      self.send("set_#{attr}", m.send(:"#{attr}"))
    end
  rescue => e
    errors.add :imdb_id, e.message
    Rails.logger.warn e
  end

  # TODO: Ugly Hack for the moment.. to map an Imdb::Movie object in a json we want
  def self.imdb_movie_to_json(imdb_movie)
    "{ 'imdb_id': #{imdb_movie.id}, 'poster': #{imdb_movie.poster}, 'title': #{imdb_movie.title}}"
  end

  private

  def set_filming_locations(locations_name)
    return if locations_name.nil?
    locations_name.each do |location_name|
      location = Location.where(address: location_name).first_or_create
      locations << location
    end
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
end
