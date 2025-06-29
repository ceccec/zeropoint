# frozen_string_literal: true

module Zeropoint
  class Railtie < Rails::Railtie
    initializer 'zeropoint.setup' do |app|
      # Configure Zeropoint
      Zeropoint.setup

      # Set up GraphQL routes
      setup_graphql_routes(app)

      # Set up middleware
      setup_middleware(app)

      # Set up root route to serve index.html
      setup_root_route(app)
    end

    private

    def setup_graphql_routes(app)
      app.routes.draw do
        # Mount GraphQL at root as I/O gateway
        post '/graphql', to: 'zeropoint/graphql#execute'
        get '/graphql', to: 'zeropoint/graphql#execute'

        # GraphQL subscription endpoint
        mount ActionCable.server => '/cable'

        # GraphQL playground (development only)
        if Rails.env.development?
          get '/graphql-playground', to: 'zeropoint/graphql#playground'
        end

        # Health check endpoint
        get '/health', to: 'zeropoint/health#check'

        # Root route serves index.html
        root to: 'zeropoint/pages#index'
      end
    end

    def setup_middleware(app)
      # Add CORS middleware for GraphQL
      app.middleware.use Rack::Cors do
        allow do
          origins '*'
          resource '/graphql', headers: :any, methods: [ :get, :post, :options ]
          resource '/cable', headers: :any, methods: [ :get, :post, :options ]
        end
      end

      # Add GraphQL context middleware
      app.middleware.use Zeropoint::GraphQL::ContextMiddleware

      # Add internationalization middleware
      app.middleware.use Zeropoint::Internationalization::Middleware

      # Add consciousness-aware error handling
      app.middleware.use Zeropoint::Consciousness::ErrorMiddleware
    end

    def setup_root_route(app)
      # Ensure root route is properly configured
      app.config.after_initialize do
        Rails.application.routes.draw do
          root to: 'zeropoint/pages#index'
        end
      end
    end
  end
end
