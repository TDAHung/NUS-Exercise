class DiscoverUserAlbumsController < ApplicationController
  def index
    @albums = Album.where(user_id: params["id"])
  end
end
