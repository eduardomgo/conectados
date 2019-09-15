Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/profiles/:id', to: 'profiles#show', as: :profile
  get '/profiles', to: 'profiles#show', as: :profiles

  root to: 'static_pages#root'
end