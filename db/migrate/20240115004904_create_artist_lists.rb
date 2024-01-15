class CreateArtistLists < ActiveRecord::Migration[7.0]
  def change
    create_table :artist_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true
      t.timestamps
    end
  end
end
