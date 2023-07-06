class DiscoverPhotosController < ApplicationController
  def index
    @photos = Photo.includes(:user).order(updated_at: :desc).where(is_public: true)
  end
end
