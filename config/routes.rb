Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  delete '/profiles/:id', to: 'profiles#destroy', as: :destroy_profile
  get '/profiles/:id', to: 'profiles#show', as: :profile
  get '/profiles', to: 'profiles#index', as: :profiles
  post '/friendship/:id', to: 'profiles#add_friend', as: :add
  get '/profiles/:id/friends', to: 'profiles#friends', as: :friends
  post '/profiles/:id/friends/accept', to: 'profiles#accept_friendship', as: :accept_friendship
  delete '/remove_fs/:id', to: 'profiles#destroy_friendship', as: :destroy_friendship

  root to: 'static_pages#root'
end