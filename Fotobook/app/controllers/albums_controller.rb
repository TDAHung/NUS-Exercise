class AlbumsController < ApplicationController
  def index
    @albums = Album.where(user_id: Current.user.id).includes(:album_attachments)
  end

  def new
    @album = Album.new
    @album_attachment = @album.album_attachments.build
  end

  def create
    @album = Album.new(album_params)
    respond_to do |format|
      if @album.save
        params[:album_attachments]['img_url'].each do |a|
           @album_attachment = @album.album_attachments.create!(:img_url => a, :album_id => @album.id)
        end
        format.html { redirect_to discover_path }
      else
        format.html { render 'new' }
      end
    end
  end

  def discover_user_index
    @albums = Album.includes(:user).includes(:album_attachments).order(updated_at: :desc).where(is_public: true)
    render "discover_user/discover_user_albums/index"
  end

  private
    def album_params
      params.require(:album).permit(:title, :description, :is_public, :user_id, album_attachments_attributes:
        [:id, :album_id, :img_url])
    end
end
