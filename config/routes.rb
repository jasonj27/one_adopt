Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  root 'pages#landingpage'

  resources :pages, only: [:index] do
    collection do
      get :newfav
      get :landingpage
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
    collection do
      get :testfav
    end
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
        post :confirm
        post :cancel_adopt
        post :adopt
      end
      resources :reservation_pets
    end
    resources :animals do
      delete '/images/:image_id' => 'animals#destroy_image', as: :destroy_image, on: :member
    end
    resource :user
    resource :calander
  end

end
