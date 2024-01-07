class Board < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_one :board_song
  has_one :song, through: :board_song
end
