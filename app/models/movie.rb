class Movie < ApplicationRecord
  validates :title, presence: true
  has_many :content, as: :contentable
  enum category: { action: 0, adventure: 1, scific_fantasy: 2, horror: 3, comedy: 4, romance: 5, human: 6, musical: 7, suspense_mystery: 8, history_biography: 9, documentary: 10, sports: 11, war: 12, western: 13 }

  def self.ransackable_attributes(auth_object = nil)
    %w[title director category]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[contents]
  end
end
