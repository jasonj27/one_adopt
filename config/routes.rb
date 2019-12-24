Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  root 'page#index'

  resources :pages, only: [:index] do
    member do
      get :newfav
    end
  end  #for landingpage


  namespace :api do
    resources :animals, only: [] do
      member do
        post :favorite # /api/animals/:id/favorite
      end
    end
  end

  resources :searches, only: [:index, :show] do #for search function
    collection do
      get :simple
      get :advance
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
