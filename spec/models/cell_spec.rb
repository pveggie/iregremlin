# frozen_string_literal: true

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
    it {
      expect(valid_cell)
        .to callback(:set_type)
        .before(:validation)
    }
  end

  describe "Instance methods" do
    before(:each) { Cell.destroy_all }
    after(:each) { Cell.destroy_all }

    describe "#set_type" do
      it "sets empty as empty" do
        create(:test_cell, content: "empty")
        expect(Cell.last.content_type).to eq("empty")
      end

      it "sets ire as ire" do
        create(:test_cell, content: "ire")
        expect(Cell.last.content_type).to eq("ire")
      end

      it "sets weapon-wielding ire as ire" do
        create(:test_cell, content: "ire-axe")
        expect(Cell.last.content_type).to eq("ire")
      end

      it "sets sword as enemy" do
        create(:test_cell, content: "sword")
        expect(Cell.last.content_type).to eq("enemy")
      end

      it "sets lance as enemy" do
        create(:test_cell, content: "lance")
        expect(Cell.last.content_type).to eq("enemy")
      end

      it "sets axe as enemy" do
        create(:test_cell, content: "axe")
        expect(Cell.last.content_type).to eq("enemy")
      end

      it "sets hill as obstacle" do
        create(:test_cell, content: "hill")
        expect(Cell.last.content_type).to eq("obstacle")
      end

      it "sets tree as obstacle" do
        create(:test_cell, content: "tree")
        expect(Cell.last.content_type).to eq("obstacle")
      end
    end
  end
end
