class PagesController < ApplicationController
  def home
    @puzzle = Puzzle.find_by(number: 1)
  end
end
