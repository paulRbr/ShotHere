class RemoveGeocodedColumns < ActiveRecord::Migration
  def up
    remove_column :movies, :location
    remove_column :movies, :latitude
    remove_column :movies, :longitude
  end

  def down
    add_column :movies, :location, :string
    add_column :movies, :latitude, :float
    add_column :movies, :longitude, :float
  end
end
