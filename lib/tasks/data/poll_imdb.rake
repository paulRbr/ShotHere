namespace :data do
  desc 'Poll data from Imdb to import movies in our database'
  task :poll_imdb => :environment do
    id = rand(999_999)
    serie = Imdb::Serie.new id
    # Create movie only if it is not a TV show..
    Movie.create(imdb_id: id) if serie.seasons.empty?
  end
end
