class RenameContentColumnToBoards < ActiveRecord::Migration[7.0]
  def change
    rename_column :boards, :content, :body
  end
end
