class Artist < ApplicationRecord
  validates :name, presence: true
  has_many :songs, foreign_key: :song_id
  has_many :artist_lists
  has_many :users, through: :artist_lists
end
