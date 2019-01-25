class Backend::PasswordsController < Devise::PasswordsController
  layout 'devise'

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash[:success] = "Change password success"
        resource.after_database_authentication
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      respond_with resource, location: new_session_path(resource)
    else
      set_minimum_password_length
      respond_with resource
    end
  end
end
