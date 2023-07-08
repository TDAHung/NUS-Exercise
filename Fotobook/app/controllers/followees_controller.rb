class FolloweesController < ApplicationController
  def index
    @followers = Follower.where(follower_id: Current.user.id)
    @followees_infos = @followers.map do |user|
      follower = User.find_by(id: user.following_user_id)
      follower.attributes.merge(album_count: follower.albums.count, photo_count: follower.photos.count, img_url: follower.img_url)
    end
    @follower_id = Follower.where(follower_id: Current.user.id)
  end

  def destroy
    follower_id = Current.user.id
    following_user_id = params[:id]
    sql_query = "DELETE FROM followers WHERE follower_id = #{follower_id} AND following_user_id = #{following_user_id}"
    ActiveRecord::Base.connection.execute(sql_query)
  end
end
