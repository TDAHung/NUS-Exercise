class Admin::AuthorizationsController < ApplicationController
  layout 'admin_layout'
  before_action :check_user
  private
    def check_user
      if current_user.nil?
        redirect_to guest_unauthorized_path
      else
        unless current_user.user_type == 'admin'
          redirect_to unauthorized_path
        end
      end
    end

end
