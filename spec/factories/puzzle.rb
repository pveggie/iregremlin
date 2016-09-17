FactoryGirl.define do
  factory :puzzle do
    number (1..100).to_a.sample
    name Faker::Book.title
    description Faker::Hipster.paragraph
  end
end
