class Song < ApplicationRecord
  validates :name, presence: true
  
  belongs_to :artist, presence: true
  has_many :post_songs
  has_many :posts, through: :post_songs

  has_many :board_songs
  has_many :board, through: :board_songs
end
