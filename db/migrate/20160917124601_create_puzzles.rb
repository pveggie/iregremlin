class CreatePuzzles < ActiveRecord::Migration[5.0]
  def change
    create_table :puzzles do |t|
      t.integer :number
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
