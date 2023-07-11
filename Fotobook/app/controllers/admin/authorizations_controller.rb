class Admin::AuthorizationsController < ApplicationController
  before_action :authorize_admin
  layout "admin_layout"
  private
  def authorize_admin
    unless Current.user.is_admin
      redirect_to discover_path
    end
  end
end
