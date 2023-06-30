class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :album, optional: true
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :img_url, presence: true
  validates :is_public, presence: true
end
