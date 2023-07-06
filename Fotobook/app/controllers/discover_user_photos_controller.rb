class DiscoverUserPhotosController < ApplicationController
  before_action :check_user

  def index
    @photos = Photo.where(user_id: params["id"])
  end

  private
  def check_user
    if params["id"] === Current.user.id.to_s
      redirect_to photos_path
    end
  end
end
