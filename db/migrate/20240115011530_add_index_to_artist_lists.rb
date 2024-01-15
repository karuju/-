class AddIndexToArtistLists < ActiveRecord::Migration[7.0]
  def change
    add_index :artist_lists, [:user_id, :artist_id], unique: true
  end
end
