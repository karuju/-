class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.integer :contentable_id, null: false
      t.string :contentable_type, null: false
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
