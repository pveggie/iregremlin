class CreateCells < ActiveRecord::Migration[5.0]
  def change
    create_table :cells do |t|
      t.references :row, foreign_key: true
      t.integer :column_number
      t.string :image
      t.string :content

      t.timestamps
    end
  end
end
