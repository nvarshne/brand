Rails.application.routes.draw do
  get 'buy_org_activations/edit'

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/register',to: 'publishers#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/get_indicator_options', to: 'proposals#get_indicator_options'
  resources :users
  resources :account_activations,   only: [:edit]
  resources :password_resets,       only: [:new, :create, :edit, :update]
  resources :proposals
  get '/proposals/:id/download', to: 'proposals#download', as: 'proposal_download'
  resources :sites,                 only: [:create, :destroy, :show, :index]
  resources :publishers
  resources :buy_orgs,              only: [:create, :destroy, :show, :index, :edit, :update]
  resources :buy_org_activations,   only: [:edit]
  resources :publisher_activations, only: [:edit]
  resources :invitations,           only: [:new, :create]
  resources :subscribers,           only: [:create, :destroy]
end
