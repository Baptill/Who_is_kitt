Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :games, only: [:create, :show] do
    resources :characteristic_questions, only: :create

    member do
      get :shifoumi
      get :invite
      patch :save_winner
      patch :select_character
      post :save_character
    end
  end
  resource :dashboard, only: :show
  resources :characteristic_questions, only: :update
  # get 'dashboard', to: 'dashboards#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
