class Anime < ApplicationRecord
  validates :title, presence: true
  has_many :content, as: :contentable
  enum category: { romance: 0, human: 1, suspense_mystery: 2, horror: 3, gag_comedy: 4, business_job: 5, medical_hospoital: 6, gourmet: 7, historical_periodical: 8, action_adventure: 9, scific_fantasy: 10, yankee: 11, gambling: 12, sports: 13 }

  def self.ransackable_attributes(auth_object = nil)
    %w[title category]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[contents]
  end
end
