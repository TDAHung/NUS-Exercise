class FollowersController < ApplicationController
  def index
    @followees = Follower.where(following_user_id: current_user.id).page(params[:page]).per(10)
    @follower_id = Follower.where(follower_id: current_user.id).page(params[:page]).per(10)
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
    @followees = Follower.where(following_user_id: params["id"]).page(params[:page]).per(10)
    @follower_id = Follower.where(follower_id: current_user.id).page(params[:page]).per(10)
    render "discover_user/discover_user_followers/index"
  end

  private
    def follower_params
      params.require(:follower).permit(:follower_id, :following_user_id)
    end
end
