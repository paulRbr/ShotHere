class AddBoxOfficeToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :box_office, :integer, :limit => 1, :default => nil
  end
end
