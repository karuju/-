class Post < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :song
  has_many :likes, as: :likeable, dependent: :destroy
  has_one :content
  has_one :comic, through: :contents, source: :contentable, source_type: 'Comic'
  has_one :novel, through: :contents, source: :contentable, source_type: 'Novel'
  has_one :movie, through: :contents, source: :contentable, source_type: 'Movie'

  def self.ransackable_attributes(auth_object = nil)
    []
  end

  def self.ransackable_associations(auth_object = nil)
    %w[song] # アソシエーション先を記述
  end
end
