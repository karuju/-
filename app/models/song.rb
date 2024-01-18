class Song < ApplicationRecord
  validates :name, presence: true
  
  belongs_to :artist
  has_many :posts
  has_many :boards
  
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["artist"] #アソシエーション先を記述
  end

end
