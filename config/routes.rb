Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}

  scope :admin do
    scope module: :backend do
      root "application#index"
    end
  end

  scope module: :frontend do
    root "application#index"
  end
end
