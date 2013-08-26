class AddRatingToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :rating, :decimal, :precision => 2
  end
end
