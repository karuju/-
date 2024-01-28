class CreateAnimes < ActiveRecord::Migration[7.0]
  def change
    create_table :animes do |t|
      t.string :title, null:false
      t.string :creator
      t.integer :category
      t.string :uri
      t.date :release_date

      t.timestamps
    end
  end
end
