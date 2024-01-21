class RemoveForeignKeyConstraints < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :answers, :boards
    remove_foreign_key :answers, :users
    remove_foreign_key :artist_lists, :artists
    remove_foreign_key :artist_lists, :users
    remove_foreign_key :boards, :songs
    remove_foreign_key :boards, :users
    remove_foreign_key :contents, :answers
    remove_foreign_key :contents, :posts
    remove_foreign_key :likes, :users
    remove_foreign_key :posts, :songs
    remove_foreign_key :posts, :users
    remove_foreign_key :songs, :artists
  end
end
