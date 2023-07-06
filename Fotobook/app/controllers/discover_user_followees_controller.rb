class DiscoverUserFolloweesController < ApplicationController
  def index
    @followers = Follower.where(follower_id: params["id"])
    @followers_infos = @followers.map do |user|
      follower = User.find_by(id: user.following_user_id)
      follower.attributes.merge(album_count: follower.albums.count, photo_count: follower.photos.count)
    end
  end
end
