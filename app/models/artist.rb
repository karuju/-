class Artist < ApplicationRecord
  validates :name, presence: true
  has_many :songs, foreign_key: :song_id
  has_many :artist_lists
  has_many :users, through: :artist_lists

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[song]
  end
end
