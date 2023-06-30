class User < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :received_follows, foreign_key: :following_user_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :received_follows, source: :follower
  has_many :given_follows, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :following_users, through: :given_follows, source: :following_user
  has_many :likes, dependent: :destroy
  has_many :liked_albums, through: :likes, source: :likeable, source_type: 'Album'
  has_many :liked_photos, through: :likes, source: :likeable, source_type: 'Photo'

  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :first_name, presence: true
  validates :password_digest, presence: true

  before_destroy :cleanup_associated_records

  private

  def cleanup_associated_records
    albums.destroy_all
    photos.destroy_all
  end

end
