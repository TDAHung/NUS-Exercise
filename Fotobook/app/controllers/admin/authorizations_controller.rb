class Admin::AuthorizationsController < ApplicationController
  before_action :authorize_admin
  layout "admin_layout"

  def index
    render '/admin/authorizations/index', layout: 'session_layout'
  end

  private
  def authorize_admin
    unless current_user.is_admin
      index
    end
  end
end
