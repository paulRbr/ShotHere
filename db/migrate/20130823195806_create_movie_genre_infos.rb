class CreateMovieGenreInfos < ActiveRecord::Migration
  def change
    create_table :movie_genre_infos do |t|
      t.string :comment
      t.integer :movie_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
