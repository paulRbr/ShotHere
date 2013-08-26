class Genre < ActiveRecord::Base

  has_many :movie_genre_infos
  has_many :movies, :through => :movie_genre_infos

  attr_accessible :name
  validates_uniqueness_of :name
end
