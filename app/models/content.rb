class Content < ApplicationRecord
  validates :contentable_id, presence: true
  validates :contentable_type, presence: true
end
