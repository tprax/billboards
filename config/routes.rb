Rails.application.routes.draw do
  devise_for :users
root 'artists#index'

resources :billboards do
  resources :songs
end

resources :artists do
  resources :songs
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end