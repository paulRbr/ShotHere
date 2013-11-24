class AddIndexToMovieDirectorInfos < ActiveRecord::Migration
  def change
    add_index :movie_director_infos, [:movie_id, :director_id]
  end
end
