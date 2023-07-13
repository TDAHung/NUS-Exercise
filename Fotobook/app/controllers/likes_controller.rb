class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    if @like.save
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  def destroy
    like_id = current_user.id
    type = params[:like][:likeable_type]
    likeable_id = params[:like][:likeable_id]
    sql_query = "DELETE FROM likes WHERE user_id = #{like_id} AND likeable_type = '#{type}' AND likeable_id = #{likeable_id}"
    if ActiveRecord::Base.connection.execute(sql_query)
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end
end
