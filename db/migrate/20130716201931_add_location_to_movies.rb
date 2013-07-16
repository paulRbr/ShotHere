class AddLocationToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :location, :string
  end
end
