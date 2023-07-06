class PhotosController < ApplicationController
  def index
    @photos = Photo.where(user_id: Current.user.id)
  end

  def new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to discover_path, notice: "Successfully created"
    else
      render :new
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :img_url, :description, :is_public, :user_id)
  end
end
