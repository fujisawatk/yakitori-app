Rails.application.routes.draw do
  devise_for :users, :controllers => {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root "posts#index"
  resources :posts

  resources :users, only: :show do
    member do
      get :mylist
    end
  end
end
