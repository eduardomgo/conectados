Rails.application.routes.draw do

  resources :posts
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  delete '/profiles/:id', to: 'profiles#destroy', as: :destroy_profile

  # Perfil de usuário
  get '/profiles/:id', to: 'profiles#show', as: :profile

  # Index e resultados de pesquisa de usuário
  get '/profiles', to: 'profiles#index', as: :profiles

  # Rota para criar pedido de amizade
  post '/friendship/:id', to: 'profiles#add_friend', as: :add

  # Pagina Para visualizar os amigos de alguem, e se o :id for seu, permite aceitar pedidos de amizade
  get '/profiles/:id/friends', to: 'profiles#friends', as: :friends

  # Aceita pedidos de amizade
  post '/profiles/:id/friends/accept', to: 'profiles#accept_friendship', as: :accept_friendship
  
  # Desfaz amizade
  delete '/remove_fs/:id', to: 'profiles#destroy_friendship', as: :destroy_friendship

  # Desfaz amizade
  delete '/profiles/:id/cancel_friendship', to: 'profiles#cancel_friendship', as: :cancel_friendship

  # Comentario
  post '/posts/:id/comment', to: 'posts#comment', as: :comment

  # Apagar comentário
  delete '/posts/:id/delete_comment/:comment_id', to: 'posts#delete_comment', as: :delete_comment

  # Like/Deslike
  patch '/posts/:id/like', to: 'posts#like', as: :like

  # Raiz - apenas para redirecionamento
  root to: 'static_pages#root'
end