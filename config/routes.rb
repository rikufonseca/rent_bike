Rails.application.routes.draw do
  devise_for :users
  root to: "bikes#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :bikes, only: [:show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :top
    end
    resources :bookings, only: [:new, :create, :edit, :update] do
      member do
        patch :accept
      end
    end
  end
  resources :bookings, only: [:destroy, :index]
  resources :messages, only: [:index]
end
