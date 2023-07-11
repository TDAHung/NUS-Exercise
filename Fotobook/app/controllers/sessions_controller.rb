class SessionsController < ApplicationController
  layout "session_layout"

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      if @user.status == 1
        session[:user_id] = @user.id
        redirect_to discover_path
      else
        redirect_to pending_path
      end
    else
      flash[:error] = "Invalid email or password"
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path, notice: "Logged out"
  end
end
