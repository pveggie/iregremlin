# frozen_string_literal: true

FactoryBot.define do
  factory :puzzle do
    number [1..100].to_a.sample
    name Faker::Book.title
    description Faker::Hipster.paragraph

    factory :two_by_two_puzzle do
      cells do
        [
          build(:cell, row_number: 0, column_number: 0),
          build(:cell, row_number: 0, column_number: 1),
          build(:cell, row_number: 1, column_number: 0),
          build(:cell, row_number: 1, column_number: 1)
        ]
      end
    end

    factory :two_enemy_puzzle do
      cells do
        [
          build(:cell, row_number: 0, column_number: 0, content: "axe"),
          build(:cell, row_number: 0, column_number: 1, content: "sword"),
          build(:cell, row_number: 1, column_number: 0, content: "ire"),
          build(:cell, row_number: 1, column_number: 1, content: "empty")
        ]
      end
    end
  end
end
