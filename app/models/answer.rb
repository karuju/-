class Answer < ApplicationRecord
  validates :body, presence: true

  belongs_to :user, presence: true
  belongs_to :board, presence: true
  has_many :likes, as: :likeable
end
