class PasswordsController < ApplicationController
  def update
    @profile = User.find(current_user.id)
    if @profile.update(user_params)
      redirect_to discover_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password)
  end
end
end
