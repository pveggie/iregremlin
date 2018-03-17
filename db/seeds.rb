# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#         1    2     3    4   5    6   7    8    9   10
Cell.destroy_all
Puzzle.destroy_all

rows = [
  ["empty", "empty", "empty", "empty", "empty", "axe", "hill", "hill", "hill", "hill"],
  ["empty", "empty", "hill", "hill", "empty", "empty", "empty", "hill", "hill", "hill"],
  ["hill", "hill", "hill", "hill", "empty", "empty", "empty", "empty", "hill", "hill"],
  ["empty", "empty", "hill", "hill", "empty", "empty", "empty", "empty", "empty", "hill"],
  ["hill", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
  ["hill", "hill", "empty", "empty", "sword", "empty", "tree", "empty", "empty", "empty"],
  ["hill", "hill", "hill", "hill", "empty", "empty", "tree", "empty", "lance", "empty"],
  ["hill", "empty", "empty", "ire", "empty", "empty", "empty", "empty", "empty", "empty"],
  ["hill", "hill", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"],
  ["hill", "hill", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"]
]

puzzle = Puzzle.create(
  number: 1,
  name: "A quest begins",
  enemies: 3
)

row_number = -1

rows.each do |row|
  row_number += 1
  col_number = -1
  row.each do |cell|
    Cell.create(
      puzzle: puzzle,
      row_number: row_number,
      column_number: col_number += 1,
      content: cell
  )
  end
end
puzzle.enemies = 3
puzzle.save
