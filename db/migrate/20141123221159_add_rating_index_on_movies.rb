class AddRatingIndexOnMovies < ActiveRecord::Migration
  def change
    add_index :movies, :rating
  end
end
