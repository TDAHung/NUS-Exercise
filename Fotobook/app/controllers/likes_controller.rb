class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @like.save
  end

  def destroy
    like_id = Current.user.id
    type = params[:likeable_type]
    likeable_id = params[:likeable_id]
    sql_query = "DELETE FROM likes WHERE user_id = #{like_id} AND likeable_type = #{type} AND likeable_id = #{likeable_id}"
    ActiveRecord::Base.connection.execute(sql_query)
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end
end
