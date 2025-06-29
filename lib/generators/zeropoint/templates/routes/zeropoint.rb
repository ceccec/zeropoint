# frozen_string_literal: true

# Zeropoint Framework Routes
# This file contains all Zeropoint-specific routes

Rails.application.routes.draw do
  # Zeropoint Dashboard
  get '/zeropoint', to: 'zeropoint#dashboard', as: :zeropoint_dashboard

  # Zeropoint Analytics
  get '/zeropoint/analytics', to: 'zeropoint#analytics', as: :zeropoint_analytics
  get '/zeropoint/analytics/:id', to: 'zeropoint#analytics_detail', as: :zeropoint_analytics_detail

  # Zeropoint Stream
  get '/zeropoint/stream', to: 'zeropoint#stream', as: :zeropoint_stream
  post '/zeropoint/stream', to: 'zeropoint#stream_create', as: :zeropoint_stream_create

  # Zeropoint Cache
  get '/zeropoint/cache', to: 'zeropoint#cache', as: :zeropoint_cache
  delete '/zeropoint/cache', to: 'zeropoint#cache_clear', as: :zeropoint_cache_clear

  # Zeropoint API v1
  namespace :api do
    namespace :v1 do
      # Main Zeropoint API
      resources :zeropoint, only: [ :index, :show ] do
        collection do
          get :status
          get :health
          get :config
        end
      end

      # Zeropoint Analytics API
      resources :zeropoint_analytics, only: [ :index, :show, :create ] do
        collection do
          get :summary
          get :trends
          post :track
        end
      end

      # Zeropoint Stream API
      resources :zeropoint_stream, only: [ :index, :show, :create ] do
        collection do
          get :realtime
          post :subscribe
          delete :unsubscribe
        end
      end
    end
  end

  # Zeropoint GraphQL endpoint
  if Zeropoint.feature_enabled?(:graphql)
    post '/graphql', to: 'graphql#execute'

    if Rails.env.development?
      mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
    end
  end
end
