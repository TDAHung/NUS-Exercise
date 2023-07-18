class AlbumsController < ApplicationController
  before_action :check_user
  def index
    @albums = Album.where(user_id: current_user.id).order(updated_at: :desc).page(params[:page]).per(8)
    @user = User.find(current_user.id)
    @followees_navbar = Follower.where(following_user_id: current_user.id)
    @followers_navbar = Follower.where(follower_id: current_user.id)
  end

  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.build(album_params)
    if @album.save
      redirect_to discover_album_path(@album.user_id)
    else
      redirect_to 'new'
    end
  end

  def edit
    @album = Album.find(params["id"])
  end

  def update
    @album = Album.find(params["id"])
    @album.update(album_params)
    redirect_to discover_album_path(@album.user_id)
  end

  def destroy
    @album = Album.find(params["id"])
    @album.destroy
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def discover_user_index
    @albums = Album.where(user_id: params["id"]).where(is_public: true).includes(:user)
    .order(updated_at: :desc).page(params[:page]).per(8)
    @user = User.find(params["id"])
    @followees_navbar = Follower.where(following_user_id: params["id"])
    @followers_navbar = Follower.where(follower_id: params["id"])
    render "albums/discover_user_albums/index"
  end

  def index_feed
    @albums = Album.includes(:user).order(updated_at: :desc).where(is_public: true).page(params[:page]).per(4)
    @likes = Like.where(likeable_type: 'Album')
    render "public/feeds/index"
  end

  def index_discover
    @albums = Album.order(updated_at: :desc).where(is_public: true).includes(:user).page(params[:page]).per(4)
    @followers = Follower.where(follower_id: current_user.id)
    @likes = Like.where(likeable_type: 'Album')
    render "public/discovers/index"
  end

  private
    def album_params
      params.require(:album).permit(:title, :description, :is_public, {album_attachments: []})
    end

    def check_user
      if params["id"] === current_user.id.to_s && action_name != 'edit'
        redirect_to albums_path
      end
    end

end
