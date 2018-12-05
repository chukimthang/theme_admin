class Backend::ApplicationController < ApplicationController
  layout "backend"

  before_action :authenticate_user!
  
  def index
  end
end
