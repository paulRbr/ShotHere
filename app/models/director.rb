class Director < ActiveRecord::Base

  has_many :movie_director_infos
  has_many :movies, :through => :movie_director_infos

  attr_accessible :name
end
