FactoryGirl.define do
  factory :row do
    puzzle { build(:puzzle) }
    row_number (1..10).to_a.sample
  end
end
