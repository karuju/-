class CreatePostSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :post_songs do |t|
      t.references :post, foreign_key: true
      t.references :song, foreign_key: true
      t.timestamps
    end
  end
end
