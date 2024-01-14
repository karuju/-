class Board < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_one :board_song, dependent: :destroy
  has_one :song, through: :board_song
  has_many :answers, dependent: :destroy
  has_many :likes, as: :likeable
end
