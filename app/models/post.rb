class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  #validates :song, presence: true

  belongs_to :user
  has_one :post_song, dependent: :destroy
  has_one :song, through: :post_song
  has_many :likes, as: :likeable
  has_one :content #, as: :contentable
  has_one :comic, through: :contents, source: :contentable, source_type: 'Comic'
  has_one :novel, through: :contents, source: :contentable, source_type: 'Novel'
  has_one :movie, through: :contents, source: :contentable, source_type: 'Movie'
end
