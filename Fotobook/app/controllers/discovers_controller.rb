class DiscoversController < ApplicationController
  def index
    @albums = Album.includes(:user).includes(:album_attachments).order(updated_at: :desc).where(is_public: true)
  end
end
