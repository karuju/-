class Song < ApplicationRecord
  validates :name, presence: true
  
  belongs_to :artist
  has_many :post_songs
  has_many :posts, through: :post_songs
end
