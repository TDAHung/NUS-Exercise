class Admin::AlbumsController < Admin::AuthorizationsController
  def index
    @albums = Album.all.includes(:album_attachments)
  end

  def edit
    @album = Album.find_by(id: params["id"])
  end

end
