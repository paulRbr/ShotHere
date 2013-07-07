require 'net/http'
require 'uri'
require 'json'

class Movie < ActiveRecord::Base
  attr_accessible :imdb_id, :title
  
  validates_presence_of :imdb_id
  validates_uniqueness_of :imdb_id
  before_validation :populate_from_imdb, :only => [:imdb_id]

  def populate_from_imdb
    uri = URI.parse("http://mymovieapi.com/?id=tt#{self.imdb_id}&type=json")
    response = Net::HTTP.get_response(uri)
    Rails.logger.debug response.body
    data = JSON.parse response.body
    self.title = data["title"]
  end

end
