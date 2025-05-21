class ChangeContentsFileSizeType < ActiveRecord::Migration[7.2]
  def change
    change_column :contents, :file_size, 'integer USING CAST(file_size AS integer)'
  end
end
