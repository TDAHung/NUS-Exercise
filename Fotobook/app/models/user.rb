class User < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :delete_all
  has_many :followers, foreign_key: 'follower_id', dependent: :delete_all
  has_many :following_users, through: :followings, source: 'following_user'
  has_many :likes, dependent: :delete_all, dependent: :destroy
  has_many :liked_albums, through: :likes, source: :likeable, source_type: 'Album'
  has_many :liked_photos, through: :likes, source: :likeable, source_type: 'Photo'

  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :first_name, presence: true
  validates :password_digest, presence: true

  before_destroy :cleanup_associated_records

  mount_uploader :img_url, AvatarUploader

  private

  def cleanup_associated_records
    albums.destroy_all
    photos.destroy_all
    likes.destroy_all
    followers.destroy_all
  end

end
