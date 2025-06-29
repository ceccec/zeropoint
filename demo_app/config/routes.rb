# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  # Mount GraphQL UI Layout engine
  mount Zeropoint::Engine => '/zeropoint'

  # Rails 8 Authentication routes
  get 'signup', to: 'registrations#new'
  post 'signup', to: 'registrations#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'confirm_email/:token', to: 'registrations#confirm_email', as: 'confirm_email'
  get 'password_reset', to: 'password_resets#new'
  post 'password_reset', to: 'password_resets#create'
  get 'password_reset/:token', to: 'password_resets#edit', as: 'edit_password_reset'
  patch 'password_reset/:token', to: 'password_resets#update'

  # Demo routes
  root 'demo#index'

  # Auth demo routes - showcase configurable authentication and authorization
  namespace :auth_demo do
    get 'public', to: 'auth_demo#public_demo'
    get 'user_only', to: 'auth_demo#user_only_demo'
    get 'role_based', to: 'auth_demo#role_based_demo'
    get 'owner_only/:post_id', to: 'auth_demo#owner_only_demo'
    get 'policy', to: 'auth_demo#policy_demo'
    get 'bulk', to: 'auth_demo#bulk_authorization_demo'
    get 'context', to: 'auth_demo#context_authorization_demo'
    get 'strategies', to: 'auth_demo#authentication_strategies_demo'
    get 'service', to: 'auth_demo#authorization_service_demo'
    get 'crud_actions', to: 'auth_demo#crud_actions_demo'
  end

  resources :posts do
    member do
      post :like
      post :share
    end
    collection do
      get :search
      get :tagged
    end
  end

  resources :users, only: [ :index, :show ] do
    member do
      get :posts
      get :followers
      get :following
    end
  end

  # API routes
  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index show create update destroy]
      resources :users, only: [ :index, :show ]
      get 'health', to: 'health#check'
    end
  end

  # Admin routes
  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :users
    resources :posts
    get 'analytics', to: 'analytics#index'
  end

  # Health check
  get 'health', to: 'health#check'
end
# rubocop:enable Metrics/BlockLength
