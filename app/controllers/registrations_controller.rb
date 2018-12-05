class RegistrationsController < Devise::RegistrationsController
  layout "devise"

  before_action :configure_permitted_parameters

  def new
    build_resource({})
    resource.build_profile
    respond_with self.resource
  end

  def show
    redirect_to new_user_registration_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [{ profile_attributes: [:full_name, :avatar, :gender] }])
  end
end
