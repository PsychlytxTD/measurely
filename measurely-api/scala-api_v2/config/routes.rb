Rails.application.routes.draw do
  root 'home#show'
  get 'home/show'
  get 'auth/oauth2/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :scale
  match 'scale', to: 'scale#update', via: [:patch, :put]
  resources :clients
  match 'clients', to: 'clients#update', via: [:patch, :put]
  # root :to => 'scale#index'
  get '/v2/logout/' => 'logout#logout'
end
