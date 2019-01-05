class ApplicationController < ActionController::Base
  include ApplicationHelper

  protected

  def after_sign_in_path_for resource
    sign_in_url = new_user_session_url

    if request.referer == sign_in_url
      admin_root_path
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  def after_sign_out_path_for resource_or_scope
    new_user_session_path
  end
end
