Rails.application.routes.draw do
  devise_for :users, controllers: {
                       omniauth_callbacks: "users/omniauth_callbacks",
                       sessions: "users/sessions",
                       confirmations: "users/confirmations",
                     }

  root "pages#introduction"

  resources :conversations, only: [:index, :show, :destroy]
  resources :users, only: [:index]
  resources :personal_messages, only: [:new, :create]
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  resources :pages, only: [:index] do
    collection do
      get :landingpage
      get :introduction
    end
  end

  namespace :api do
    resources :animals, only: [] do
      member do
        post :favorite
      end
    end
  end

  resources :searches, only: [:index, :show] do
    collection do
      get :simple
      get :advance
      post :lucky_show
      get :lucky_animal
    end
  end

  resources :favorites, only: [:index, :destroy] do
    collection do
      delete :destroy_all
    end
  end

  resources :reservations, only: [:index, :new, :create] do
    member do
      delete :cancel
    end
  end

  namespace :sender do
    root "pages#index"
    resources :reservations, only: [:index] do
      member do
        delete :cancel
        post :confirm
        post :cancel_adopt
        post :adopt
      end
    end
    resources :animals, only: [:index, :new, :create, :edit, :update, :destroy] do
      delete "/images/:image_id" => "animals#destroy_image", as: :destroy_image, on: :member
    end
    resource :user, only: [:edit, :update]
  end
end
