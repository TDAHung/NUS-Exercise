class FeedPhotosController < ApplicationController
  def index
    @photos = Photo.includes(:user).order(created_at: :desc).where(is_public: true)
  end
end
