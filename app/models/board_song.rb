class BoardSong < ApplicationRecord
  belongs_to :board
  belongs_to :song
=begin
  def self.ransackable_attributes(auth_object = nil)
    ["song_id"]
  end


  def self.ransackable_associations(auth_object = nil)
    ["song"]  #アソシエーション先を記述
  end
=end
end
