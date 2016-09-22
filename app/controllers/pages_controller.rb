class PagesController < ApplicationController
  def home
    @puzzle_rows = Puzzle.find_by(number: 1).rows
  end
end
