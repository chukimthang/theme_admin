class Backend::RegistrationsController < Devise::RegistrationsController
  layout "devise"

  before_action :configure_permitted_parameters

  def new
    build_resource({})
    resource.build_profile
    respond_with self.resource
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        flash[:success] = "Registration success"
        respond_with resource, location: new_session_path(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def show
    redirect_to new_user_registration_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [{ profile_attributes: [:full_name, :avatar, :gender] }])
  end
end
