class FollowersController < ApplicationController
  def index
    @followees = Follower.where(following_user_id: current_user.id)
    @followers_infos = @followees.map do |user|
      followee = User.find_by(id: user.follower_id)
      followee.attributes.merge(album_count: followee.albums.count, photo_count: followee.photos.count, img_url: followee.img_url)
    end
    @follower_id = Follower.where(follower_id: current_user.id)
  end

  def create
    @follower = Follower.new(follower_params)
    if @follower.save
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  def discover_follower_index
    @followees = Follower.where(following_user_id: params["id"])
    @followers_infos = @followees.map do |user|
      followee = User.find_by(id: user.follower_id)
      followee.attributes.merge(album_count: followee.albums.count, photo_count: followee.photos.count, img_url: followee.img_url)
    end
    @follower_id = Follower.where(follower_id: current_user.id)
    render "discover_user/discover_user_followers/index"
  end

  private
    def follower_params
      params.require(:follower).permit(:follower_id, :following_user_id)
    end
end
