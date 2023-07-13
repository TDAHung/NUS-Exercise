class ProfilesController < ApplicationController
  def edit
    @profile = current_user
  end

  def update
    @profile = User.find(params[:id])
    if @profile.update(status_user_params)
      redirect_to discover_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :img_url, :first_name, :last_name, :status)
  end

  def status_user_params
    if params.require(:user)["status"]
      user_params
    else
      params.require(:user).permit(:email, :img_url, :first_name, :last_name).merge(status: "inactive")
    end
  end
end
