# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie_genre_info do
    comment "MyString"
    movie_id 1
    genre_id 1
  end
end
