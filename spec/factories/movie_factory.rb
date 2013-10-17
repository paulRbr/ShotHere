FactoryGirl.define do
  factory :movie do
    imdb_id "1130884"
  end
  factory :scarface, class: Movie do
    imdb_id "086250"
  end
end
