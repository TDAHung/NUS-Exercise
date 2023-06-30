class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following_user, class_name: 'User'
end
