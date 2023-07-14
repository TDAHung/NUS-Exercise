class DiscoversController < ApplicationController
  def index
    @albums = Album.order(updated_at: :desc).where(is_public: true).includes(:user).page(params[:page]).per(4)
    @follower_id = Follower.where(follower_id: current_user.id)
    @like_id = Like.where(likeable_type: 'Album')
  end

  def index_feed
    @albums = Album.includes(:user).order(updated_at: :desc).where(is_public: true).page(params[:page]).per(4)
    @like_id = Like.where(likeable_type: 'Album')
    render "feeds/index"
  end
end
