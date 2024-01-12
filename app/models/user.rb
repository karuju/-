class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true, validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  enum sex: { male: 0, female: 1, not_to_say: 2 }

  has_many :boards
  has_many :posts
  has_many :answers


  def assign_boards_and_answers_and_posts_to_deleted_user
    deleted_user_id = 1
    Board.where(user_id: id).update_all(user_id: deleted_user_id)
    Answer.where(user_id: id).update_all(user_id: deleted_user_id)
    Post.where(user_id: id).update_all(user_id: deleted_user_id)
  end
end
