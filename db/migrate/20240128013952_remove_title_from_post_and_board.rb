class RemoveTitleFromPostAndBoard < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :title, :string
    remove_column :boards, :title, :string
  end
end
