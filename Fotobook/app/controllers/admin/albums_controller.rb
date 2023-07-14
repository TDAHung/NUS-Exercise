class Admin::AlbumsController < Admin::AuthorizationsController
  def index
    @albums = Album.all
  end

  def edit
    @album = Album.find_by(id: params["id"])
  end
end
