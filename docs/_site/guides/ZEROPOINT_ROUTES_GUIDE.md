# Zeropoint Routes Mounting Guide

## Overview

Zeropoint can be mounted in Rails routes at any desired namespace, providing flexible integration options for different application architectures and requirements.

## Basic Mounting

### 1. Default Mounting

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount Zeropoint at the default /zeropoint path
  mount Zeropoint::Engine => '/zeropoint'
end
```

### 2. Custom Namespace Mounting

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount Zeropoint at a custom namespace
  mount Zeropoint::Engine => '/my-zeropoint'
  
  # Or with a more descriptive path
  mount Zeropoint::Engine => '/cosmic-framework'
  
  # Or with versioning
  mount Zeropoint::Engine => '/api/v1/zeropoint'
end
```

## Advanced Mounting Options

### 1. Nested Namespace Mounting

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount within a namespace
  namespace :admin do
    mount Zeropoint::Engine => '/zeropoint'
  end
  
  # Mount within API namespace
  namespace :api do
    namespace :v1 do
      mount Zeropoint::Engine => '/zeropoint'
    end
  end
  
  # Mount within a custom namespace
  namespace :cosmic do
    mount Zeropoint::Engine => '/matrix'
  end
end
```

### 2. Conditional Mounting

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount only in specific environments
  if Rails.env.development? || Rails.env.test?
    mount Zeropoint::Engine => '/dev/zeropoint'
  end
  
  # Mount based on feature flags
  if FeatureFlag.enabled?(:zeropoint)
    mount Zeropoint::Engine => '/zeropoint'
  end
  
  # Mount with different paths per environment
  case Rails.env
  when 'development'
    mount Zeropoint::Engine => '/dev/zeropoint'
  when 'staging'
    mount Zeropoint::Engine => '/staging/zeropoint'
  when 'production'
    mount Zeropoint::Engine => '/zeropoint'
  end
end
```

### 3. Multiple Mount Points

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount Zeropoint at multiple locations for different purposes
  mount Zeropoint::Engine => '/admin/zeropoint', as: 'admin_zeropoint'
  mount Zeropoint::Engine => '/api/zeropoint', as: 'api_zeropoint'
  mount Zeropoint::Engine => '/public/zeropoint', as: 'public_zeropoint'
end
```

## Configuration-Based Mounting

### 1. Dynamic Mounting from Configuration

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount based on Zeropoint configuration
  zeropoint_config = Zeropoint.configuration
  
  if zeropoint_config.mount_path
    mount Zeropoint::Engine => zeropoint_config.mount_path
  else
    mount Zeropoint::Engine => '/zeropoint'
  end
end
```

### 2. Environment-Specific Configuration

```ruby
# config/environments/development.rb
Rails.application.configure do
  config.zeropoint = {
    mount_path: '/dev/zeropoint',
    mount_as: 'dev_zeropoint'
  }
end

# config/environments/production.rb
Rails.application.configure do
  config.zeropoint = {
    mount_path: '/zeropoint',
    mount_as: 'zeropoint'
  }
end

# config/routes.rb
Rails.application.routes.draw do
  mount_path = Rails.application.config.zeropoint[:mount_path] || '/zeropoint'
  mount_as = Rails.application.config.zeropoint[:mount_as] || 'zeropoint'
  
  mount Zeropoint::Engine => mount_path, as: mount_as
end
```

## Custom Route Integration

### 1. Custom Routes with Zeropoint Integration

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount Zeropoint
  mount Zeropoint::Engine => '/zeropoint'
  
  # Custom routes that integrate with Zeropoint
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
```

### 2. Zeropoint-Aware Custom Controllers

```ruby
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
```

## Subdomain Mounting

### 1. Subdomain-Based Mounting

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount Zeropoint on a subdomain
  constraints subdomain: 'zeropoint' do
    mount Zeropoint::Engine => '/'
  end
  
  # Mount on different subdomains for different environments
  constraints subdomain: 'dev-zeropoint' do
    mount Zeropoint::Engine => '/' if Rails.env.development?
  end
  
  constraints subdomain: 'staging-zeropoint' do
    mount Zeropoint::Engine => '/' if Rails.env.staging?
  end
end
```

## Mounting with Constraints

### 1. Authentication Constraints

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount Zeropoint with authentication constraints
  constraints lambda { |req| req.env['warden'].authenticated? } do
    mount Zeropoint::Engine => '/zeropoint'
  end
  
  # Mount with role-based constraints
  constraints lambda { |req| req.env['warden'].user&.admin? } do
    mount Zeropoint::Engine => '/admin/zeropoint'
  end
end
```

### 2. Feature Flag Constraints

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount based on feature flags
  constraints lambda { |req| FeatureFlag.enabled?(:zeropoint, req.env['warden'].user) } do
    mount Zeropoint::Engine => '/zeropoint'
  end
end
```

## Mounting with Custom Configuration

### 1. Mounting with Engine Configuration

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount with custom engine configuration
  mount Zeropoint::Engine => '/zeropoint' do
    # Custom configuration for this mount point
    Zeropoint.configure do |config|
      config.mount_point = '/zeropoint'
      config.isolation_level = :full
      config.cross_origin = true
    end
  end
end
```

### 2. Mounting with Different Configurations

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount with different configurations for different purposes
  mount Zeropoint::Engine => '/admin/zeropoint' do
    Zeropoint.configure do |config|
      config.admin_mode = true
      config.debug = true
    end
  end
  
  mount Zeropoint::Engine => '/api/zeropoint' do
    Zeropoint.configure do |config|
      config.api_mode = true
      config.json_only = true
    end
  end
end
```

## URL Generation and Helpers

### 1. URL Helpers for Mounted Engine

```ruby
# After mounting Zeropoint::Engine => '/zeropoint'
# These URL helpers become available:

# Main Zeropoint paths
zeropoint.root_path                    # => "/zeropoint"
zeropoint.universal_matrix_path        # => "/zeropoint/universal_matrix"
zeropoint.possibility_discovery_path   # => "/zeropoint/possibility_discovery"

# API paths
zeropoint.api_v1_universal_matrix_path # => "/zeropoint/api/v1/universal_matrix"
zeropoint.api_v1_consciousness_path    # => "/zeropoint/api/v1/consciousness_physics"
```

### 2. Custom URL Helpers

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount with custom URL helpers
  mount Zeropoint::Engine => '/cosmic', as: 'cosmic' do
    # Custom URL helpers
    get :matrix, to: 'universal_matrix#index', as: 'matrix'
    get :vortex, to: 'vortex_mathematics#index', as: 'vortex'
  end
end

# Usage:
cosmic_matrix_path  # => "/cosmic/matrix"
cosmic_vortex_path  # => "/cosmic/vortex"
```

## Testing Mounted Routes

### 1. Route Testing

```ruby
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
end
```

### 2. Integration Testing

```ruby
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
end
```

## Production Considerations

### 1. Load Balancing

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount Zeropoint with load balancing considerations
  if Rails.env.production?
    # Use CDN for static assets
    mount Zeropoint::Engine => '/zeropoint', constraints: { subdomain: 'api' }
  else
    mount Zeropoint::Engine => '/zeropoint'
  end
end
```

### 2. Caching

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Mount with caching considerations
  mount Zeropoint::Engine => '/zeropoint' do
    # Configure caching for this mount point
    Zeropoint.configure do |config|
      config.cache_enabled = true
      config.cache_ttl = 3600
    end
  end
end
```

## Summary

Zeropoint can be mounted in Rails routes with complete flexibility:

1. **Basic Mounting**: Simple mount at any desired path
2. **Namespace Mounting**: Mount within any Rails namespace
3. **Conditional Mounting**: Mount based on environment or feature flags
4. **Multiple Mounts**: Mount at multiple locations for different purposes
5. **Custom Integration**: Integrate Zeropoint with custom routes and controllers
6. **Subdomain Mounting**: Mount on specific subdomains
7. **Constraint-Based Mounting**: Mount with authentication or feature flag constraints
8. **Configuration-Based Mounting**: Mount with custom engine configurations

This flexibility allows developers to integrate Zeropoint seamlessly into any Rails application architecture while maintaining full control over the mounting location and configuration. 