class AddForeignKeyToAnswerIdInContents < ActiveRecord::Migration[7.0]
  def change
    change_column :contents, :answer_id, :bigint
    add_foreign_key :contents, :answers, column: :answer_id
  end
end
