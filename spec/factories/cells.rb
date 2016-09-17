FactoryGirl.define do
  factory :cell do
    row { build(:row) }
    column_number (1..10).to_a.sample
    content %w(axe sword lance ire tree hill).sample
  end
end
