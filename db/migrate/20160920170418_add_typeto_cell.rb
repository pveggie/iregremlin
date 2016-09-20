class AddTypetoCell < ActiveRecord::Migration[5.0]
  def change
    add_column :cells, :type, :string
  end
end
