# frozen_string_literal: true

# Controllers related to puzzle pages
class PagesController < ApplicationController
  def home
    @puzzle = Puzzle.find_by(number: 1)
    @puzzle_rows = @puzzle.rows
  end
end
