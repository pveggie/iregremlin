# frozen_string_literal: true

FactoryBot.define do
  factory :cell do
    content %w[axe sword lance ire tree hill].sample

    factory :test_cell do
      puzzle { build(:puzzle) }
      row_number [1..10].to_a.sample
      column_number [1..10].to_a.sample
    end
  end
end
