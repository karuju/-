class Artist < ApplicationRecord
  validates :name, presence: true
  has_many :songs, foreign_key: :song_id
end
