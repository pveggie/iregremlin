require 'rails_helper'

RSpec.describe Cell, type: :model do
  it "has a valid factory for cells with puzzle data" do
    expect(build(:test_cell)).to be_valid
  end

  it "has a valid factory for basic cells" do
    expect(build(:cell)).to be_valid
  end

  let(:valid_cell) { build(:test_cell) }

  describe "ActiveRecord Associations" do
    it { expect(valid_cell).to belong_to(:puzzle) }
  end

  describe "Callbacks" do
    it { expect(valid_cell)
      .to callback(:set_type)
      .before(:validation)
    }
  end

  describe "Instance methods" do
    before(:each) { Cell.destroy_all }
    after(:each) {Cell.destroy_all}

    it "#set_type sets the cell's type" do
      create(:test_cell, content: "sword")
      expect(Cell.last.content_type).to eq("enemy")
    end
  end
end
