class AddAnswerIdToContents < ActiveRecord::Migration[7.0]
  def change
    add_reference :contents, :answer, foreign_key: true
  end
end
