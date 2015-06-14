FactoryGirl.define do
  factory :director do
    name "Quentin Tarantino"
  end
  factory :brian, class: Director do
    name "Brian"
  end
end
