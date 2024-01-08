class CreateBoardSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :board_songs do |t|
      t.references :board, foreign_key: true
      t.references :song, foreign_key: true
      t.timestamps
    end
  end
end
