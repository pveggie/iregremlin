class CreateRows < ActiveRecord::Migration[5.0]
  def change
    create_table :rows do |t|
      t.references :puzzle, foreign_key: true, index: true
      t.integer :row_number

      t.timestamps
    end
  end
end
