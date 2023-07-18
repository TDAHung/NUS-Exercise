class FolloweesController < ApplicationController
  def index
    @followers = Follower.where(follower_id: current_user.id).page(params[:page]).per(10)
    @followees = Follower.where(following_user_id: current_user.id).page(params[:page]).per(10)
    @user = User.find(current_user.id)
    @followees_navbar = Follower.where(following_user_id: current_user.id)
    @followers_navbar = Follower.where(follower_id: current_user.id)
  end

  def destroy
    follower_id = current_user.id
    following_user_id = params[:id]
    url = URI.parse(request.referrer).path
    desired_portion = url.split('/')[1]
    discover_id = url.split('/')[3]
    if desired_portion == "discovers"
      followees_navbar = Follower.where(following_user_id: discover_id)
    else
      followees_navbar = Follower.where(follower_id: follower_id)
    end
    case params[:type_asset]
    when 'Album'
      following_user = Album.where(user_id: params[:id]).first
    when 'Photo'
      following_user = Photo.where(user_id: params[:id]).first
    end
    followers = Follower.where(follower_id: current_user.id)
    sql_query = "DELETE FROM followers WHERE follower_id = #{follower_id} AND following_user_id = #{following_user_id}"
    if ActiveRecord::Base.connection.execute(sql_query)
        if params[:type_asset]
          respond_to do |format|
            format.turbo_stream { render turbo_stream: turbo_stream.replace_all(".follow-#{following_user_id}", partial: 'shared/button/follow/discover',
              locals:{asset: following_user, followers: followers, type_asset: params[:type_asset]}) }
          end
        else
          respond_to do |format|
            format.turbo_stream do
              render turbo_stream: [
                turbo_stream.replace("follow-#{following_user_id}",
                  partial: 'shared/button/follow/user',
                  locals: { followees: followers, user_id: following_user_id }),
                turbo_stream.replace("follower_tab",
                  partial: "shared/navbar/follower_navbar",
                  locals: { followees_count: followees_navbar.count }),
                turbo_stream.replace("followee_tab",
                  partial: "shared/navbar/followee_navbar",
                  locals: { followers_count: followees_navbar.count })
              ]
              end
          end
        end
    end
  end

  def discover_followee_index
    @followers = Follower.where(follower_id: params["id"]).page(params[:page]).per(10)
    @followees = Follower.where(follower_id: current_user.id).page(params[:page]).per(10)
    @user = User.find(params["id"])
    @followees_navbar = Follower.where(following_user_id: params["id"])
    @followers_navbar = Follower.where(follower_id: params["id"])
    render "followees/discover_user_followees/index"
  end
end
