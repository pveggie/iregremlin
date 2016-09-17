require 'rails_helper'

RSpec.describe Cell, type: :model do
  it "has a valid factory" do
    expect(create(:cell)).to be_valid
  end

  let(:valid_cell) { build(:cell) }

  describe "ActiveRecord Associations" do
    it { expect(valid_cell).to belong_to(:row) }
  end

  describe "Callbacks" do
    it { expect(valid_cell)
      .to callback(:set_image)
      .before(:validation)
      .if(:image_missing?) }

  end

  describe "Instance methods" do
    before(:each) { Cell.destroy_all }
    after(:each) {Cell.destroy_all}

    it "#set_image sets the cell's image to content + '.jpg' if no image is provided" do
       create(:cell, content: "hello", image: nil)
       expect(Cell.last.image).to eq("hello.jpg")
    end

    it "#set_image leaves the cell's image as nil if the content is nil" do
      create(:cell, content: nil, image: nil)
      expect(Cell.last.image).to eq(nil)
    end

    it "#set_image is not called if image is provided" do
      create(:cell, content: "hello", image: "goodbye.jpg")
      expect(Cell.last.image).to eq("goodbye.jpg")
    end
  end
end
