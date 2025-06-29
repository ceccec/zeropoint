# Zeropoint Mounting Examples
# This file demonstrates various ways to mount Zeropoint in Rails routes

# =============================================================================
# EXAMPLE 1: Basic Mounting
# =============================================================================

# config/routes.rb - Basic mounting
Rails.application.routes.draw do
  # Simple mount at default path
  mount Zeropoint::Engine => '/zeropoint'
end

# Usage:
# - Visit: http://localhost:3000/zeropoint
# - API: http://localhost:3000/zeropoint/api/v1/universal_matrix
# - Helpers: zeropoint.root_path, zeropoint.universal_matrix_path

# =============================================================================
# EXAMPLE 2: Custom Namespace Mounting
# =============================================================================

# config/routes.rb - Custom namespace
Rails.application.routes.draw do
  # Mount at custom path
  mount Zeropoint::Engine => '/cosmic-framework'

  # Mount with versioning
  mount Zeropoint::Engine => '/api/v2/zeropoint'

  # Mount with descriptive name
  mount Zeropoint::Engine => '/consciousness-matrix'
end

# Usage:
# - Visit: http://localhost:3000/cosmic-framework
# - API: http://localhost:3000/api/v2/zeropoint/api/v1/universal_matrix
# - Helpers: cosmic_framework.root_path, api_v2_zeropoint.root_path

# =============================================================================
# EXAMPLE 3: Nested Namespace Mounting
# =============================================================================

# config/routes.rb - Nested namespaces
Rails.application.routes.draw do
  # Mount within admin namespace
  namespace :admin do
    mount Zeropoint::Engine => '/zeropoint'
  end

  # Mount within API namespace
  namespace :api do
    namespace :v1 do
      mount Zeropoint::Engine => '/zeropoint'
    end
  end

  # Mount within custom namespace
  namespace :cosmic do
    mount Zeropoint::Engine => '/matrix'
  end
end

# Usage:
# - Admin: http://localhost:3000/admin/zeropoint
# - API: http://localhost:3000/api/v1/zeropoint
# - Cosmic: http://localhost:3000/cosmic/matrix
# - Helpers: admin_zeropoint.root_path, api_v1_zeropoint.root_path, cosmic_matrix.root_path

# =============================================================================
# EXAMPLE 4: Environment-Based Mounting
# =============================================================================

# config/routes.rb - Environment-specific mounting
Rails.application.routes.draw do
  # Mount based on environment
  case Rails.env
  when 'development'
    mount Zeropoint::Engine => '/dev/zeropoint'
  when 'staging'
    mount Zeropoint::Engine => '/staging/zeropoint'
  when 'production'
    mount Zeropoint::Engine => '/zeropoint'
  end

  # Conditional mounting
  if Rails.env.development? || Rails.env.test?
    mount Zeropoint::Engine => '/debug/zeropoint'
  end
end

# Usage:
# - Development: http://localhost:3000/dev/zeropoint
# - Staging: https://staging.example.com/staging/zeropoint
# - Production: https://example.com/zeropoint
# - Debug: http://localhost:3000/debug/zeropoint (dev/test only)

# =============================================================================
# EXAMPLE 5: Multiple Mount Points
# =============================================================================

# config/routes.rb - Multiple mount points
Rails.application.routes.draw do
  # Mount for different purposes
  mount Zeropoint::Engine => '/admin/zeropoint', as: 'admin_zeropoint'
  mount Zeropoint::Engine => '/api/zeropoint', as: 'api_zeropoint'
  mount Zeropoint::Engine => '/public/zeropoint', as: 'public_zeropoint'
end

# Usage:
# - Admin: http://localhost:3000/admin/zeropoint
# - API: http://localhost:3000/api/zeropoint
# - Public: http://localhost:3000/public/zeropoint
# - Helpers: admin_zeropoint.root_path, api_zeropoint.root_path, public_zeropoint.root_path

# =============================================================================
# EXAMPLE 6: Configuration-Based Mounting
# =============================================================================

# config/environments/development.rb
Rails.application.configure do
  config.zeropoint = {
    mount_path: '/dev/zeropoint',
    mount_as: 'dev_zeropoint',
    debug: true
  }
end

# config/environments/production.rb
Rails.application.configure do
  config.zeropoint = {
    mount_path: '/zeropoint',
    mount_as: 'zeropoint',
    debug: false
  }
end

# config/routes.rb - Dynamic mounting from configuration
Rails.application.routes.draw do
  # Get configuration from Rails
  mount_path = Rails.application.config.zeropoint[:mount_path] || '/zeropoint'
  mount_as = Rails.application.config.zeropoint[:mount_as] || 'zeropoint'

  # Mount with configuration
  mount Zeropoint::Engine => mount_path, as: mount_as
end

# =============================================================================
# EXAMPLE 7: Custom Route Integration
# =============================================================================

# config/routes.rb - Custom routes with Zeropoint integration
Rails.application.routes.draw do
  # Mount Zeropoint
  mount Zeropoint::Engine => '/zeropoint'

  # Custom routes that use Zeropoint
  namespace :api do
    namespace :v1 do
      resources :posts do
        collection do
          # Use Zeropoint's consciousness search
          get :consciousness_search, to: 'posts#consciousness_search'

          # Use Zeropoint's vortex analytics
          get :vortex_analytics, to: 'posts#vortex_analytics'

          # Use Zeropoint's unified intelligence
          get :unified_intelligence_query, to: 'posts#unified_intelligence_query'
        end
      end

      # Custom Zeropoint endpoints
      get :universal_matrix, to: 'zeropoint#universal_matrix'
      get :possibility_discovery, to: 'zeropoint#possibility_discovery'
      get :consciousness_physics, to: 'zeropoint#consciousness_physics'
    end
  end
end

# app/controllers/api/v1/posts_controller.rb
class Api::V1::PostsController < ApplicationController
  include Zeropoint::ControllerConcern

  def consciousness_search
    term = params[:q]
    results = Post.consciousness_search(term)
    render json: { results: results }
  end

  def vortex_analytics
    analytics = Post.vortex_analytics
    render json: analytics
  end

  def unified_intelligence_query
    query_data = params[:query]
    results = Post.unified_intelligence_query(query_data)
    render json: { results: results }
  end
end

# app/controllers/api/v1/zeropoint_controller.rb
class Api::V1::ZeropointController < ApplicationController
  include Zeropoint::ControllerConcern

  def universal_matrix
    matrix_data = Zeropoint.universal_matrix.generate(
      user: current_user,
      context: request.context
    )
    render json: matrix_data
  end

  def possibility_discovery
    discoveries = Zeropoint.discover_possibilities(
      context: { user: current_user, request: request }
    )
    render json: discoveries
  end

  def consciousness_physics
    physics_data = Zeropoint.consciousness_physics.analyze(
      user: current_user,
      path: request.path
    )
    render json: physics_data
  end
end

# Usage:
# - Zeropoint: http://localhost:3000/zeropoint
# - Custom API: http://localhost:3000/api/v1/posts/consciousness_search?q=test
# - Custom Matrix: http://localhost:3000/api/v1/universal_matrix

# =============================================================================
# EXAMPLE 8: Subdomain Mounting
# =============================================================================

# config/routes.rb - Subdomain mounting
Rails.application.routes.draw do
  # Mount on specific subdomain
  constraints subdomain: 'zeropoint' do
    mount Zeropoint::Engine => '/'
  end

  # Mount on different subdomains per environment
  constraints subdomain: 'dev-zeropoint' do
    mount Zeropoint::Engine => '/' if Rails.env.development?
  end

  constraints subdomain: 'staging-zeropoint' do
    mount Zeropoint::Engine => '/' if Rails.env.staging?
  end
end

# Usage:
# - Development: http://dev-zeropoint.localhost:3000
# - Staging: http://staging-zeropoint.staging.example.com
# - Production: http://zeropoint.example.com

# =============================================================================
# EXAMPLE 9: Authentication Constraints
# =============================================================================

# config/routes.rb - Authentication constraints
Rails.application.routes.draw do
  # Mount with authentication
  constraints lambda { |req| req.env['warden'].authenticated? } do
    mount Zeropoint::Engine => '/zeropoint'
  end

  # Mount with admin role
  constraints lambda { |req| req.env['warden'].user&.admin? } do
    mount Zeropoint::Engine => '/admin/zeropoint'
  end

  # Mount with feature flag
  constraints lambda { |req| FeatureFlag.enabled?(:zeropoint, req.env['warden'].user) } do
    mount Zeropoint::Engine => '/featured/zeropoint'
  end
end

# Usage:
# - Authenticated: http://localhost:3000/zeropoint (requires login)
# - Admin: http://localhost:3000/admin/zeropoint (requires admin role)
# - Featured: http://localhost:3000/featured/zeropoint (requires feature flag)

# =============================================================================
# EXAMPLE 10: Custom Configuration Mounting
# =============================================================================

# config/routes.rb - Custom configuration
Rails.application.routes.draw do
  # Mount with custom configuration
  mount Zeropoint::Engine => '/zeropoint' do
    Zeropoint.configure do |config|
      config.mount_point = '/zeropoint'
      config.isolation_level = :full
      config.cross_origin = true
      config.debug = Rails.env.development?
    end
  end

  # Mount with different configurations
  mount Zeropoint::Engine => '/admin/zeropoint' do
    Zeropoint.configure do |config|
      config.admin_mode = true
      config.debug = true
      config.consciousness_physics.enabled = true
    end
  end

  mount Zeropoint::Engine => '/api/zeropoint' do
    Zeropoint.configure do |config|
      config.api_mode = true
      config.json_only = true
      config.cache_enabled = true
    end
  end
end

# =============================================================================
# EXAMPLE 11: Testing Routes
# =============================================================================

# spec/routing/zeropoint_routes_spec.rb
require 'rails_helper'

RSpec.describe 'Zeropoint Routes', type: :routing do
  describe 'mounted engine' do
    it 'routes to universal matrix' do
      expect(get: '/zeropoint/universal_matrix').to route_to(
        controller: 'zeropoint/universal_matrix',
        action: 'index'
      )
    end

    it 'routes to possibility discovery' do
      expect(get: '/zeropoint/possibility_discovery').to route_to(
        controller: 'zeropoint/possibility_discovery',
        action: 'index'
      )
    end
  end

  describe 'custom API routes' do
    it 'routes to consciousness search' do
      expect(get: '/api/v1/posts/consciousness_search').to route_to(
        controller: 'api/v1/posts',
        action: 'consciousness_search'
      )
    end
  end
end

# spec/requests/zeropoint_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Zeropoint Integration', type: :request do
  describe 'GET /zeropoint/universal_matrix' do
    it 'returns universal matrix data' do
      get '/zeropoint/universal_matrix'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include('matrix_data')
    end
  end

  describe 'GET /api/v1/posts/consciousness_search' do
    it 'performs consciousness search' do
      get '/api/v1/posts/consciousness_search', params: { q: 'test' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include('results')
    end
  end
end

# =============================================================================
# EXAMPLE 12: Production Considerations
# =============================================================================

# config/routes.rb - Production-ready mounting
Rails.application.routes.draw do
  if Rails.env.production?
    # Production: Use CDN and load balancing
    constraints subdomain: 'api' do
      mount Zeropoint::Engine => '/zeropoint'
    end

    # Production: Mount with caching
    mount Zeropoint::Engine => '/zeropoint' do
      Zeropoint.configure do |config|
        config.cache_enabled = true
        config.cache_ttl = 3600
        config.minification = true
      end
    end
  else
    # Development: Simple mounting
    mount Zeropoint::Engine => '/zeropoint'
  end
end

# =============================================================================
# SUMMARY OF URL HELPERS
# =============================================================================

# After mounting Zeropoint::Engine => '/zeropoint', these helpers are available:
#
# Basic paths:
# zeropoint.root_path                    # => "/zeropoint"
# zeropoint.universal_matrix_path        # => "/zeropoint/universal_matrix"
# zeropoint.possibility_discovery_path   # => "/zeropoint/possibility_discovery"
#
# API paths:
# zeropoint.api_v1_universal_matrix_path # => "/zeropoint/api/v1/universal_matrix"
# zeropoint.api_v1_consciousness_path    # => "/zeropoint/api/v1/consciousness_physics"
#
# Custom mount points:
# admin_zeropoint.root_path              # => "/admin/zeropoint"
# api_zeropoint.root_path                # => "/api/zeropoint"
# cosmic_matrix.root_path                # => "/cosmic/matrix"

# =============================================================================
# USAGE EXAMPLES
# =============================================================================

# In views:
# <%= link_to "Zeropoint Matrix", zeropoint.universal_matrix_path %>
# <%= link_to "Admin Zeropoint", admin_zeropoint.root_path %>

# In controllers:
# redirect_to zeropoint.possibility_discovery_path
# redirect_to api_zeropoint.api_v1_universal_matrix_path

# In JavaScript:
# fetch('/zeropoint/api/v1/universal_matrix')
# fetch('/api/v1/posts/consciousness_search?q=test')

# In tests:
# get zeropoint.universal_matrix_path
# get api_v1_posts_consciousness_search_path(q: 'test')
