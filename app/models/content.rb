class Content < ApplicationRecord
  validates :contentable_id, presence: true
  validates :contentable_type, presence: true
  belongs_to :post
  belongs_to :answer
  belongs_to :contentable, polymorphic: true
end
