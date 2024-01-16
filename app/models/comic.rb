class Comic < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true

  has_many :content, as: :contentable
end
