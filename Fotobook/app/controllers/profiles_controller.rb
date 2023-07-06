class ProfilesController < ApplicationController
  def edit
    @profile = Current.user
  end

  def update
    @profile = User.find(Current.user.id)
    puts user_params
    if @profile.update(user_params)
      redirect_to discover_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :img_url, :first_name, :last_name)
  end
end
