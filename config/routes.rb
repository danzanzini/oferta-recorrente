# frozen_string_literal: true

Rails.application.routes.draw do
  resources :harvests, except: %i[index destroy]
  resources :offerings do
    member do
      get :print
    end
  end
  resources :locations
  resources :products, except: :destroy
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#home'

  resource :session, only: %i[new create destroy]
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
