class AddEnemiesToPuzzles < ActiveRecord::Migration[5.0]
  def change
    add_column :puzzles, :enemies, :integer
  end
end
