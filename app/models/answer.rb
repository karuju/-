class Answer < ApplicationRecord
  validates :body, presence: true

  belongs_to :user
  belongs_to :board
  has_many :likes, as: :likeable
  has_one :content, dependent: :destroy
  has_one :comic, through: :contents, source: :contentable, source_type: 'Comic'
  has_one :novel, through: :contents, source: :contentable, source_type: 'Novel'
  has_one :movie, through: :contents, source: :contentable, source_type: 'Movie'

end
