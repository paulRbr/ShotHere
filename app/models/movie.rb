require 'net/http'
require 'uri'

class Movie < ActiveRecord::Base
  attr_accessible :imdb_id, :title
  
  before_validation :imdb_id_exists?

  private
  def imdb_id_exists?
    uri = URI.parse("http://mymovieapi.com/?id=tt#{@imdb_id}&type=json")
    response = Net::HTTP.get_response(uri)
    Rails.logger.debug response.body
    true
  end

end
