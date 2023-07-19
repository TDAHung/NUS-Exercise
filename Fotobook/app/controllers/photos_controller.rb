class PhotosController < ApplicationController
  before_action :check_user_status
  before_action :check_user
  def index
    @photos = Photo.where(user_id: current_user.id).order(updated_at: :desc).page(params[:page]).per(10)
    query_navbar(current_user.id)
  end

  def new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to discover_photo_path(@photo.user_id)
    else
      render :new
    end
  end

  def edit
    @photo = Photo.find_by(id: params["id"])
  end

  def update
    @photo = Photo.find_by(id: params["id"])
    if @photo.update(photo_params)
      redirect_to discover_photo_path(@photo.user_id)
    else
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params["id"])
    @photo.destroy
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def discover_user_photos_index
    @photos = Photo.where(user_id: params["id"]).order(updated_at: :desc).page(params[:page]).per(10)
    query_navbar(params[:id])
    render "photos/discover_user_photos/index"
  end

  def index_discover
    @photos = Photo.includes(:user).order(updated_at: :desc).where(is_public: true).page(params[:page]).per(4)
    @followers = Follower.where(follower_id: current_user.id)
    @likes = Like.where(likeable_type: 'Photo')
    render "public/discover_photos/index"
  end

  def index_feed
    @photos = Photo.includes(:user).order(created_at: :desc).where(is_public: true).page(params[:page]).per(4)
    @likes = Like.where(likeable_type: 'Photo')
    render "public/feed_photos/index"
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :img_url, :description, :is_public, :user_id)
  end

  def check_user
    if params["id"] === current_user.id.to_s && action_name != 'edit'
      redirect_to photos_path
    end
  end

  def query_navbar(id)
    @user = User.find(id)
    @followees_navbar = Follower.where(following_user_id: id)
    @followers_navbar = Follower.where(follower_id: id)
  end
end
