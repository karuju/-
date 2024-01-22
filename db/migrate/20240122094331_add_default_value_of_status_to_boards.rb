class AddDefaultValueOfStatusToBoards < ActiveRecord::Migration[7.0]
  def change
    change_column_default :boards, :status, from: nil, to: "0"
  end
end
