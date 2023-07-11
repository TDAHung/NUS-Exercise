class DiscoversController < ApplicationController
  def index
    @albums = Album.includes(:user).includes(:album_attachments).order(updated_at: :desc).where(is_public: true)
    @follower_id = Follower.where(follower_id: Current.user.id)
    @like_id = Like.where(likeable_type: 'Album')
  end

  def index_feed
    @albums = Album.includes(:user).includes(:album_attachments).order(updated_at: :desc).where(is_public: true)
    @like_id = Like.where(likeable_type: 'Album')
    render "feeds/index"
  end
end
