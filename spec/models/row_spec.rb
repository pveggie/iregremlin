require 'rails_helper'

RSpec.describe Row, type: :model do
  it "has a valid factory" do
    expect(create(:row)).to be_valid
  end

  let(:valid_row) { build(:row) }

  describe "ActiveRecord associations" do
    # Associations
    it { expect(valid_row).to belong_to(:puzzle) }
    it { expect(valid_row).to have_many(:cells).dependent(:destroy)}
  end
end
