namespace :data do
  desc 'Poll data from Imdb to update box office movies'
  task :update_box_office => :environment do
    old_box_office = Movie.where.not(box_office: nil).pluck(:imdb_id)
    new_box_office = Imdb::BoxOffice.new.movies.map(&:id)

    # Get new movies and set box office flag on them
    new_box_office.each_with_index do |imdb_id, position|
      exist = Movie.where(imdb_id: imdb_id)
      sleep 2 if exist.empty? # Take your time if we'll poll movie from imdb
      m = exist.first_or_create(imdb_id: imdb_id)
      m.update(box_office: position+1)
    end

    # Remove old box office movies
    Movie.where(imdb_id: old_box_office).update_all(box_office: nil)
  end
end
