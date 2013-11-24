class AddIndexToMovieLocationInfos < ActiveRecord::Migration
  def change
    add_index :movie_location_infos, [:movie_id, :location_id]
  end
end
