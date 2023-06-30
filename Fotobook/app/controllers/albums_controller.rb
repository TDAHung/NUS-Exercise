class AlbumsController < ApplicationController
  def index
    @query = Album.joins(:user).all
    @albums = @query.map do |query|
      query.attributes.merge(user_id: query.user.id ,user_first_name: query.user.first_name,
        user_last_name: query.user.last_name, user_img_url: query.user.img_url)
    end
  end
end
