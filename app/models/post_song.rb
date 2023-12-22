class PostSong < ApplicationRecord
  belongs_to :post
  belongs_to :song
end
