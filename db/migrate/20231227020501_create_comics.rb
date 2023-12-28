class CreateComics < ActiveRecord::Migration[7.0]
  def change
    create_table :comics do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.integer :category
      t.text :summary
      t.string :uri
      t.string :publisher
      t.date :published_year

      t.timestamps
    end
  end
end
