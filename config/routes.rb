Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  root 'pages#index'

  resource :pages, only: [:index]  #for landingpage

  resources :searches, only: [:index, :show] do #for search function
    collection do
      get :simple
    end
  end

  resources :favorites #for favorite function

  resources :reservations do  #for reservation function
    member do
      delete :cancel
    end
  end

  resource :calander  #for reservation calander function
  resources :messages

  namespace :sender do
    root 'pages#index'
    resources :reservations do
      member do
        delete :cancel
      end
    end
    resource :calander
  end

end
