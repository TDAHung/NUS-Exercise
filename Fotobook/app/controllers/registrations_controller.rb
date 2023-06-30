class RegistrationsController < ApplicationController
  layout "session_layout"
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully created"
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :password, :password_confirmation, :img_url, :last_name, :is_admin)
  end
end
