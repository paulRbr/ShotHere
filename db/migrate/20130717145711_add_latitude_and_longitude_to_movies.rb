class AddLatitudeAndLongitudeToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :latitude, :float
    add_column :movies, :longitude, :float
  end
end
