Rails.application.routes.draw do
  devise_for :user, controllers: {
    sessions: 'backend/sessions',
    passwords: 'backend/passwords',
    registrations: 'backend/registrations'
  }

  scope :admin, as: :admin do
    scope module: :backend do
      root 'home#index'
      resources :users do
        member do
          post :change_status
        end
      end
      resources :groups, except: [:new, :show] do
        resources :categories, except: [:show]
      end
    end
  end

  scope module: :frontend do
    root 'application#index'
  end
end
