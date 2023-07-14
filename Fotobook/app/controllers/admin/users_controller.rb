class Admin::UsersController < Admin::AuthorizationsController
  def index
    @users = User.where(user_type: 2)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_photos_path
  end

  def edit
    @profile = User.find(params[:id])
  end
end
