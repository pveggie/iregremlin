require 'rails_helper'

RSpec.describe "pages/home.html.erb", type: :view do

  describe "puzzle grid" do
    before do
      puzzle = create(:two_by_two_puzzle, number: 1)
      puzzle_rows = puzzle.rows
      assign(:puzzle_rows, puzzle_rows)
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
