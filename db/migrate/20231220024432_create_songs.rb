class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :uri
      t.string :image
      t.date :release_date
      t.belongs_to :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
