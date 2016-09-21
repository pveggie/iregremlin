class PagesController < ApplicationController
  def home
    @puzzle_rows = Puzzle
                    .find_by(number: 1)
                    .cells
                    .group_by { |cell| cell[:row_number] }
                    .map { |array| array[1] }
  end
end
