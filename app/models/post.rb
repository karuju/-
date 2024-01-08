class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  #validates :song, presence: true

  belongs_to :user
  has_one :post_song
  has_one :song, through: :post_song
end
