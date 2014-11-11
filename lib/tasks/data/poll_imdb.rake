namespace :data do
  desc 'Poll data from Imdb to import movies in our database'
  task :poll_imdb => :environment do
    Movie.create imdb_id: rand(999_999)
  end
end
