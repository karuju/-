class Novel < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  has_many :content, as: :contentable
  enum category: { romance: 0, human: 1, suspense_mystery: 2, horror: 3, gag_comedy: 4, scific_fantasy: 5, business_job: 6, medical_hospoital: 7, gourmet: 8, historical_periodical: 9, politics: 10, light_novel: 11, childrens_literature: 12 }

  def self.ransackable_attributes(auth_object = nil)
    %w[title author category]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[contents]
  end
end
