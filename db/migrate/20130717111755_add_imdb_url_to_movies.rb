class AddImdbUrlToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :imdb_url, :string
  end
end
