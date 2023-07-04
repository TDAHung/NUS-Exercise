class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :album, optional: true
  has_many :likes, as: :likeable, dependent: :delete_all
  has_many :liking_users, through: :likes, source: :user

  validates :img_url, presence: true
  validates :is_public, inclusion: { in: [true, false], allow_nil: true }
end
