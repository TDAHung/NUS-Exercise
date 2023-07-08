class DiscoverPhotosController < ApplicationController
  def index
    @photos = Photo.includes(:user).order(updated_at: :desc).where(is_public: true)
    @follower_id = Follower.where(follower_id: Current.user.id)
  end
end
