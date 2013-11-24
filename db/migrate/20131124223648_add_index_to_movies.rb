class AddIndexToMovies < ActiveRecord::Migration
  def change
    add_index :movies, [:title, :imdb_id, :rating]
  end
end
