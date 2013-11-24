class AddIndexToMovieGenreInfos < ActiveRecord::Migration
  def change
    add_index :movie_genre_infos, [:movie_id, :genre_id]
  end
end
