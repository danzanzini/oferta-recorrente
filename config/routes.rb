# frozen_string_literal: true

Rails.application.routes.draw do
  resources :harvests, except: %i[index]
  resources :offerings do
    member do
      get :print
    end
  end
  resources :locations
  resources :products
  resources :users do
    collection do
      get   :edit_password
      patch :update_password
    end
    member { post :toggle_active }
    resources :subscriptions, only: %i[new create edit update]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#home'

  resource :session, only: %i[new create destroy]
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
