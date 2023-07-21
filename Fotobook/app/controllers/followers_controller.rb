class FollowersController < ApplicationController
  before_action :check_user_status

  def index
    query(current_user.id)
  end

  def create
    @follower = Follower.new(follower_params)
    url = URI.parse(request.referrer).path
    desired_portion = url.split('/')[1]
    discover_id = url.split('/')[3]
    if desired_portion != "discovers"
      followees_navbar = Follower.where(follower_id: current_user.id)
    else
      followees_navbar = Follower.where(following_user_id: discover_id)
    end
    case params[:type_asset]
    when 'Album'
      asset = Album.where(user_id: follower_params[:following_user_id]).first
    when 'Photo'
      asset = Photo.where(user_id: follower_params[:following_user_id]).first
    end
    followers = Follower.where(follower_id: current_user.id)
    if @follower.save
      if !params[:type_asset].nil?
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace_all(".follow-#{follower_params[:following_user_id]}",
            partial: 'shared/button/follow/discover',
            locals:{asset: asset, followers: followers, type_asset: params[:type_asset]}) }
        end
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace("follow-#{follower_params[:following_user_id]}",
                partial: 'shared/button/follow/user',
                locals: { followees: followers, user_id: follower_params[:following_user_id] }),
              turbo_stream.replace("followee_tab",
                partial: "shared/navbar/followee_navbar",
                locals: { followers_count: followers.count }),
              turbo_stream.replace("follower_tab",
                partial: "shared/navbar/follower_navbar",
                locals: { followees_count: followees_navbar.count })
            ]
          end
        end
      end
    end
  end

  def discover_follower_index
    query(params["id"])
    render "followers/discover_user_followers/index"
  end

  private
    def follower_params
      params.require(:follower).permit(:follower_id, :following_user_id)
    end

    def query(id)
      @followees = Follower.where(following_user_id: id).includes(:follower).page(params[:page]).per(8)
      @followers = Follower.where(follower_id: current_user.id).page(params[:page]).per(8)
      @user = User.find(id)
      @followees_navbar = Follower.where(following_user_id: id)
      @followers_navbar = Follower.where(follower_id: id)
    end
end
