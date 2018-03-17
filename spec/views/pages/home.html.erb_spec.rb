# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "pages/home.html.erb", type: :view do
  describe "puzzle grid" do
    before do
      puzzle = create(:two_by_two_puzzle, number: 1)
      puzzle_rows = puzzle.rows
      assign(:puzzle_rows, puzzle_rows)
      assign(:puzzle, puzzle)
    end

    it "renders a table with rows and cells" do
      render
      expect(render).to match('table')
      expect(render).to match('tr')
      expect(render).to match('td')
    end

    it "renders and id with the row and column as 'col-row' coordinates" do
      render
      expect(render).to match(/id=\"1\-1\"/)
    end
  end

  describe "puzzle info" do
    before do
      puzzle = create(:two_enemy_puzzle, number: 1, name: "Title Time")
      puzzle_rows = puzzle.rows
      assign(:puzzle_rows, puzzle_rows)
      assign(:puzzle, puzzle)
    end

    it "renders the puzzle number" do
      render
      expect(render).to have_text('Puzzle 1')
    end

    it "renders the puzzle name" do
      render
      expect(render).to match('Title Time')
    end

    # it "renders the round number" do
    #   render
    #   expect(render).to have_text('Round: 1')
    # end

    # it "renders the number of enemies" do
    #   render
    #   expect(render).to have_text('Enemies Remaining: 2')
    # end

    # it "renders Ire's HP" do
    #   render
    #   expect(render).to have_text('HP: 20')
    # end

    # it "renders Ire's weapon" do
    #   render
    #   expect(render).to have_text('Weapon: None')
    # end

    # it "renders Ire's movement range" do
    #   render
    #   expect(render).to have_text('Range: 5')
    # end
  end
end

# before(:each) do
#   assign(:categories, [
#     build(:category, name: "Concerts"),
#     build(:category, name: "Animals")
#   ])
#   assign(:photos, [
#     build(:remote_photo, caption_title: "Test One", categories: [build(:category, name: "Concerts")]),
#     build(:remote_photo, caption_title: "Test Two", categories: [build(:category, name: "Concerts")])
#   ])
# end

# after(:each) do
#   Photo.destroy_all
# end
