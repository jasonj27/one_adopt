Rails.application.routes.draw do
  devise_for :users

  root 'page#index'

  resource :page, only: [:index]  #for landingpage

  resource :search, only: [:index] #for search function

  resources :favorites #for favorite function

  resources :reservations do  #for reservation function
    member do
      delete :cancel
    end
  end

  resource :calander  #for reservation calander function
  resources :messages

  namespace :sender do
    root 'page#index'
    resources :reservations do
      member do
        delete :cancel
      end
    end
    resource :calander
  end

end
