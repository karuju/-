class Board < ApplicationRecord
  validates :body, presence: true

  belongs_to :user
  belongs_to :song
  has_many :answers, dependent: :destroy
  has_many :likes, as: :likeable

  enum status: { open: 0, closed: 1 }

  def self.ransackable_attributes(auth_object = nil)
    [ ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["song"]  #アソシエーション先を記述
  end
end
