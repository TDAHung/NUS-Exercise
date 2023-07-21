class Album < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :delete_all
  has_many :liking_users, through: :likes, source: :user
  mount_uploaders :album_attachments, PhotoUploader

  validates :is_public, inclusion: { in: [true, false], allow_nil: true }
  validates :title, presence: { message: "Title of album is required" }
  validates :album_attachments, presence: { message: "Album is required"}
end
