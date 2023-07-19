class LikesController < ApplicationController
  before_action :check_user_status

  def create
    @like = Like.new(like_params)
    likeable_id = params[:like][:likeable_id]
    type_asset = params[:like][:likeable_type]
    case type_asset
    when 'Album'
      likes = Like.where(likeable_type: 'Album')
      asset = Album.find(likeable_id)
    when 'Photo'
      likes = Like.where(likeable_type: 'Photo')
      asset = Photo.find(likeable_id)
    end
    if @like.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("like-#{likeable_id}",
          partial: 'shared/button/like',
          locals:{asset: asset, likes: likes, type_asset: type_asset}) }
      end
    end
  end

  def destroy
    like_id = current_user.id
    type_asset = params[:like][:likeable_type]
    likeable_id = params[:like][:likeable_id]
    case type_asset
    when 'Album'
      likes = Like.where(likeable_type: 'Album')
      asset = Album.find(likeable_id)
    when 'Photo'
      likes = Like.where(likeable_type: 'Photo')
      asset = Photo.find(likeable_id)
    end

    sql_query = "DELETE FROM likes WHERE user_id = #{like_id} AND likeable_type = '#{type_asset}' AND likeable_id = #{likeable_id}"
    if ActiveRecord::Base.connection.execute(sql_query)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("like-#{likeable_id}",
          partial: 'shared/button/like',
          locals:{asset: asset, likes: likes, type_asset: type_asset}) }
      end
    end
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end
end
