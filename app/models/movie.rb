class Movie < ApplicationRecord
  validates :title, presence: true

  has_many :content, as: :contentable
end
