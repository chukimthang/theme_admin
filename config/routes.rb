Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}

  scope :admin, as: :admin do
    scope module: :backend do
      root "home#index"
      resources :users
      resources :groups, except: [:new, :show]
    end
  end

  scope module: :frontend do
    root "application#index"
  end
end
