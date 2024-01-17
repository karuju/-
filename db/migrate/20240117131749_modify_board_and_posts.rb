class ModifyBoardAndPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :boards, :song, foreign_key: true
    add_reference :posts, :song, foreign_key: true
    drop_table :board_songs
    drop_table :post_songs
  end
end
