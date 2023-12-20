class Post < ApplicationRecord
  validates :title null: false
  validates :content null: false
end
