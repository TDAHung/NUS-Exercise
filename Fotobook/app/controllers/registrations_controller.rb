class RegistrationsController < Devise::RegistrationsController
  layout "session_layout"

  def new_user_registration
  end
end
