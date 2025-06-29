# Zeropoint Mounting Quick Reference

## 🚀 Quick Start

```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount Zeropoint::Engine => '/zeropoint'
end
```

## 📍 Common Mounting Patterns

### Basic Mounting
```ruby
# Default mount
mount Zeropoint::Engine => '/zeropoint'

# Custom path
mount Zeropoint::Engine => '/cosmic-framework'

# Versioned mount
mount Zeropoint::Engine => '/api/v1/zeropoint'
```

### Namespace Mounting
```ruby
# Admin namespace
namespace :admin do
  mount Zeropoint::Engine => '/zeropoint'
end

# API namespace
namespace :api do
  namespace :v1 do
    mount Zeropoint::Engine => '/zeropoint'
  end
end

# Custom namespace
namespace :cosmic do
  mount Zeropoint::Engine => '/matrix'
end
```

### Environment-Based Mounting
```ruby
# Environment-specific paths
case Rails.env
when 'development'
  mount Zeropoint::Engine => '/dev/zeropoint'
when 'staging'
  mount Zeropoint::Engine => '/staging/zeropoint'
when 'production'
  mount Zeropoint::Engine => '/zeropoint'
end

# Development/Test only
if Rails.env.development? || Rails.env.test?
  mount Zeropoint::Engine => '/debug/zeropoint'
end
```

### Multiple Mount Points
```ruby
# Different purposes
mount Zeropoint::Engine => '/admin/zeropoint', as: 'admin_zeropoint'
mount Zeropoint::Engine => '/api/zeropoint', as: 'api_zeropoint'
mount Zeropoint::Engine => '/public/zeropoint', as: 'public_zeropoint'
```

## 🔐 Authentication & Constraints

### Authentication Required
```ruby
# Require authentication
constraints lambda { |req| req.env['warden'].authenticated? } do
  mount Zeropoint::Engine => '/zeropoint'
end

# Admin only
constraints lambda { |req| req.env['warden'].user&.admin? } do
  mount Zeropoint::Engine => '/admin/zeropoint'
end
```

### Feature Flag Constraints
```ruby
# Feature flag required
constraints lambda { |req| FeatureFlag.enabled?(:zeropoint, req.env['warden'].user) } do
  mount Zeropoint::Engine => '/zeropoint'
end
```

## 🌐 Subdomain Mounting

```ruby
# Specific subdomain
constraints subdomain: 'zeropoint' do
  mount Zeropoint::Engine => '/'
end

# Environment-specific subdomains
constraints subdomain: 'dev-zeropoint' do
  mount Zeropoint::Engine => '/' if Rails.env.development?
end
```

## ⚙️ Configuration-Based Mounting

```ruby
# From Rails config
mount_path = Rails.application.config.zeropoint[:mount_path] || '/zeropoint'
mount_as = Rails.application.config.zeropoint[:mount_as] || 'zeropoint'

mount Zeropoint::Engine => mount_path, as: mount_as
```

## 🎛️ Custom Configuration

```ruby
# Mount with custom config
mount Zeropoint::Engine => '/zeropoint' do
  Zeropoint.configure do |config|
    config.debug = Rails.env.development?
    config.cache_enabled = true
    config.consciousness_physics.enabled = true
  end
end

# Different configs per mount
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
```

## 🔗 URL Helpers

After mounting, these helpers become available:

```ruby
# Basic paths
zeropoint.root_path                    # => "/zeropoint"
zeropoint.universal_matrix_path        # => "/zeropoint/universal_matrix"
zeropoint.possibility_discovery_path   # => "/zeropoint/possibility_discovery"

# API paths
zeropoint.api_v1_universal_matrix_path # => "/zeropoint/api/v1/universal_matrix"
zeropoint.api_v1_consciousness_path    # => "/zeropoint/api/v1/consciousness_physics"

# Custom mount points
admin_zeropoint.root_path              # => "/admin/zeropoint"
api_zeropoint.root_path                # => "/api/zeropoint"
cosmic_matrix.root_path                # => "/cosmic/matrix"
```

## 🧪 Testing

```ruby
# Route testing
expect(get: '/zeropoint/universal_matrix').to route_to(
  controller: 'zeropoint/universal_matrix',
  action: 'index'
)

# Request testing
get '/zeropoint/universal_matrix'
expect(response).to have_http_status(:ok)
```

## 🚀 Production Ready

```ruby
# Production with caching and optimization
if Rails.env.production?
  mount Zeropoint::Engine => '/zeropoint' do
    Zeropoint.configure do |config|
      config.cache_enabled = true
      config.cache_ttl = 3600
      config.minification = true
    end
  end
else
  mount Zeropoint::Engine => '/zeropoint'
end
```

## 📝 Usage Examples

### In Views
```erb
<%= link_to "Zeropoint Matrix", zeropoint.universal_matrix_path %>
<%= link_to "Admin Zeropoint", admin_zeropoint.root_path %>
```

### In Controllers
```ruby
redirect_to zeropoint.possibility_discovery_path
redirect_to api_zeropoint.api_v1_universal_matrix_path
```

### In JavaScript
```javascript
fetch('/zeropoint/api/v1/universal_matrix')
fetch('/api/v1/posts/consciousness_search?q=test')
```

## 🎯 Most Common Patterns

### 1. Simple Development Setup
```ruby
Rails.application.routes.draw do
  mount Zeropoint::Engine => '/zeropoint'
end
```

### 2. Production with Admin
```ruby
Rails.application.routes.draw do
  mount Zeropoint::Engine => '/zeropoint'
  
  namespace :admin do
    mount Zeropoint::Engine => '/zeropoint'
  end
end
```

### 3. API Integration
```ruby
Rails.application.routes.draw do
  mount Zeropoint::Engine => '/zeropoint'
  
  namespace :api do
    namespace :v1 do
      mount Zeropoint::Engine => '/zeropoint'
    end
  end
end
```

### 4. Environment-Aware
```ruby
Rails.application.routes.draw do
  case Rails.env
  when 'development'
    mount Zeropoint::Engine => '/dev/zeropoint'
  when 'production'
    mount Zeropoint::Engine => '/zeropoint'
  end
end
```

## 🔧 Troubleshooting

### Check if Zeropoint is mounted
```ruby
# In Rails console
Rails.application.routes.routes.map(&:path).grep(/zeropoint/)
```

### List all Zeropoint routes
```ruby
# In Rails console
Rails.application.routes.routes.select { |r| r.path.spec.to_s.include?('zeropoint') }
```

### Test URL helpers
```ruby
# In Rails console
app.zeropoint.root_path
app.admin_zeropoint.root_path if defined?(app.admin_zeropoint)
``` 