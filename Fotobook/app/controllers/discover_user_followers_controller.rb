class DiscoverUserFollowersController < ApplicationController
  def index
    @followees = Follower.where(following_user_id: params["id"])
    @followees_infos = @followees.map do |user|
      followee = User.find_by(id: user.follower_id)
      followee.attributes.merge(album_count: followee.albums.count, photo_count: followee.photos.count, img_url: followee.img_url)
    end
    @follower_id = Follower.where(follower_id: Current.user.id)
  end
end
