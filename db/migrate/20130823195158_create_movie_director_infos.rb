class CreateMovieDirectorInfos < ActiveRecord::Migration
  def change
    create_table :movie_director_infos do |t|
      t.integer :movie_id
      t.integer :director_id
      t.string :comment

      t.timestamps
    end
  end
end
