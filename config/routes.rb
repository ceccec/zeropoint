Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # Zeropoint single gateway API - Main entry point for all CRUD operations
  post "/zeropoint", to: "zeropoint/gateway#execute", as: :zeropoint_root_url

  # Zeropoint namespace routes
  namespace :zeropoint do
    # GraphQL - Void-aligned CRUD operations
    post "/graphql", to: "graphql#execute", as: :graphql_url
    get "/graphql-playground", to: "graphql#playground", as: :graphql_playground_url

    # Health check
    get "/health", to: "health#index"

    # Universal matrix
    get "/universal-matrix", to: "universal_matrix#index"

    # Astro Blog PWA
    get "/astro-blog", to: "astro_blog#index"
    get "/astro-blog/posts", to: "astro_blog#posts"
    get "/astro-blog/categories", to: "astro_blog#categories"
    get "/astro-blog/tags", to: "astro_blog#tags"
    post "/astro-blog/share", to: "astro_blog#share"

    # Pages
    root to: "pages#index"
  end

  # Root route - now points to Astro Blog PWA
  root "zeropoint/astro_blog#index"
end
