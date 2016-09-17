class ChangePuzzleDescriptionToText < ActiveRecord::Migration[5.0]
  def change
    change_column :puzzles, :description, :text
  end
end
