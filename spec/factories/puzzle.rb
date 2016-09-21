FactoryGirl.define do
  factory :puzzle do
    number (1..100).to_a.sample
    name Faker::Book.title
    description Faker::Hipster.paragraph

    factory :two_by_two_puzzle do
      cells {[
        build(:cell, row_number: 0, column_number: 0),
        build(:cell, row_number: 0, column_number: 1),
        build(:cell, row_number: 1, column_number: 0),
        build(:cell, row_number: 1, column_number: 1)
      ]}
    end
  end
end
