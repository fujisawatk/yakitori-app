Rails.application.routes.draw do
  devise_for :users
  root "infos#index"
  resources :infos, only: [:index]
end
