class DiscoverPhotosController < ApplicationController
  def index
    @photos = Photo.includes(:user).order(updated_at: :desc).where(is_public: true).page(params[:page]).per(4)
    @follower_id = Follower.where(follower_id: current_user.id)
    @like_id = Like.where(likeable_type: 'Photo')
  end

  def feed_photos_index
    @photos = Photo.includes(:user).order(created_at: :desc).where(is_public: true).page(params["page"]).per(4)
    @like_id = Like.where(likeable_type: 'Photo')
    render "feed_photos/index"
  end
end
