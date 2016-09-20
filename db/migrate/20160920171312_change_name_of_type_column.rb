class ChangeNameOfTypeColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :cells, :type, :content_type
  end
end
