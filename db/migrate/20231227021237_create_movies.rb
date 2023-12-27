class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :director
      t.string :leading_actor
      t.integer :category
      t.text :summary
      t.string :distributer
      t.date :published_year
      t.string :uri

      t.timestamps
    end
  end
end
