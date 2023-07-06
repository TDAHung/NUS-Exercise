class FolloweesController < ApplicationController
  def index
    @followers = Follower.where(follower_id: Current.user.id)
    @followees_infos = @followers.map do |user|
      follower = User.find_by(id: user.following_user_id)
      follower.attributes.merge(album_count: follower.albums.count, photo_count: follower.photos.count)
    end
  end
end
