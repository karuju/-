class Novel < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true

  has_many :content, as: :contentable

  def self.ransackable_attributes(auth_object = nil)
    ["title", "author", "category"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["contents"]
  end

end
