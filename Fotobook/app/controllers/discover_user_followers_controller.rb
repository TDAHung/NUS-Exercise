class DiscoverUserFollowersController < ApplicationController
  def index
    @followees = Follower.where(following_user_id: params["id"])
    @followees_infos = @followees.map do |user|
      followee = User.find_by(id: user.follower_id)
      followee.attributes.merge(album_count: followee.albums.count, photo_count: followee.photos.count)
    end
  end
end
