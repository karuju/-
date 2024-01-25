class User < ApplicationRecord
  authenticates_with_sorcery!

  mount_uploader :image, ImageUploader
  
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  enum sex: { male: 0, female: 1, not_to_say: 2 }
  enum role: { user: 0, admin: 1 }

  has_many :boards
  has_many :posts
  has_many :answers
  has_many :likes, dependent: :destroy
  has_many :artist_lists
  has_many :artists, through: :artist_lists

  def own?(object)
    id == object&.user_id
  end


  def assign_boards_and_answers_and_posts_to_deleted_user
    deleted_user_id = 1
    Board.where(user_id: id).update_all(user_id: deleted_user_id)
    Answer.where(user_id: id).update_all(user_id: deleted_user_id)
    Post.where(user_id: id).update_all(user_id: deleted_user_id)
  end

  def add_to_artist_list(artist)
    artists << artist
  end

  def remove_from_artist_list(artist)
    artists.destroy(artist)
  end

  def listed_artist?(artist)
    artists.include?(artist)
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "name", "email" ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["answers", "artist_lists", "artists", "boards", "likes", "posts"]
  end
end
