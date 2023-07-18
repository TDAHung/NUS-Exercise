class Admin::UsersController < Admin::AuthorizationsController
  def index
    @users = User.where(user_type: 2).page(params[:page]).per(4)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_photos_path
  end

  def edit
    @profile = User.find(params[:id])
  end

  def update
    puts params
  end
end
