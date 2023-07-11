class Admin::PhotosController < Admin::AuthorizationsController
  def index
    @photos = Photo.order(updated_at: :desc)
  end

  def edit
    @photo = Photo.find_by(id: params["id"])
  end

end
