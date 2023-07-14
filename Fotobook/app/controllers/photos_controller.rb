class PhotosController < ApplicationController
  before_action :check_user
  def index
    @photos = Photo.where(user_id: current_user.id).order(updated_at: :desc).page(params[:page]).per(10)
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
    if @photo.update(photo_params_update)
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
    @photos = Photo.where(user_id: params["id"]).order(updated_at: :desc).where(is_public: true).page(params[:page]).per(10)
    render "discover_user/discover_user_photos/index"
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :img_url, :description, :is_public, :user_id)
  end

  def photo_params_update
    if params.require(:photo)["img_url"].nil? == true
      params.require(:photo).permit(:title, :description, :is_public, :user_id)
    else
      photo_params
    end
  end

  def check_user
    if params["id"] === current_user.id.to_s && action_name != 'edit'
      redirect_to photos_path
    end
  end

end
