class CreateMovieLocationInfos < ActiveRecord::Migration
  def change
    create_table :movie_location_infos do |t|
      t.integer :movie_id
      t.integer :location_id
      t.string :comment

      t.timestamps
    end
  end
end
