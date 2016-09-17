require 'rails_helper'

RSpec.describe Cell, type: :model do
  it "has a valid factory" do
    expect(create(:cell)).to be_valid
  end

  let(:valid_cell) { build(:cell) }

  describe "ActiveRecord Associations" do
    it { expect(valid_cell).to belong_to(:row) }
  end
end
