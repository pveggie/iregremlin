# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#         1    2     3    4   5    6   7    8    9   10
Cell.destroy_all
Row.destroy_all
Puzzle.destroy_all

rows = [
  [nil, nil, nil, nil, nil, "axe", "hill", "hill", "hill", "hill"],
  [nil, nil, "hill", "hill", nil, nil, nil, "hill", "hill", "hill"],
  ["hill", "hill", "hill", "hill", nil, nil, nil, nil, "hill", "hill"],
  [nil, nil, "hill", "hill", nil, nil, nil, nil, nil, "hill"],
  ["hill", nil, nil, nil, nil, nil, nil, nil, nil, nil],
  ["hill", "hill", nil, nil, "sword", nil, "tree", nil, nil, nil],
  ["hill", "hill", "hill", "hill", nil, nil, "tree", nil, "lance", nil],
  ["hill", nil, nil, "ire", nil, nil, nil, nil, nil, nil],
  ["hill", "hill", nil, nil, nil, nil, nil, nil, nil, nil],
  ["hill", "hill", nil, nil, nil, nil, nil, nil, nil, nil]
]



puzzle = Puzzle.create(
  number: 1,
  name: "A quest begins",
)

row_number = -1

rows.each do |row|
  created_row = Row.create(row_number: row_number += 1, puzzle: puzzle)

  col_number = -1
  row.each do |cell|
    Cell.create(column_number: col_number += 1, row: created_row, content: cell)
  end
end
