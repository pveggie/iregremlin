# frozen_string_literal: true

class CreateCells < ActiveRecord::Migration[5.0]
  def change
    create_table :cells do |t|
      t.references :puzzle, foreign_key: true, index: true
      t.integer :row_number
      t.integer :column_number
      t.string :content
      t.string :content_type

      t.timestamps
    end
  end
end
