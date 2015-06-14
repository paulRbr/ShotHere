FactoryGirl.define do
  factory :movie do
    imdb_id "1130884"
    title "Shutter Island"
    rating 9
  end
  factory :scarface, class: Movie do
    imdb_id "086250"
    title "Scarface"
    rating 8.9
  end
end
