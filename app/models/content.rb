class Content < ApplicationRecord
  validates :contentable_id, presence: true
  validates :contentable_type, presence: true
  belongs_to :post, optional: true
  belongs_to :answer, optional: true
  belongs_to :contentable, polymorphic: true
end
