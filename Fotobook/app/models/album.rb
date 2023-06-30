class Album < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :is_public, inclusion: { in: [true, false], allow_nil: true }
end
