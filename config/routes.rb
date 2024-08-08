Rails.application.routes.draw do
  get 'messages/index'
  get 'bookings/index'
  devise_for :users
  root to: "pages#landing"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :bikes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :top
    end
    resources :bookings, only: [:new, :create, :edit, :update]
  end
  resources :bookings, only: [:destroy, :index]
  resources :messages, only: [:index]
end
