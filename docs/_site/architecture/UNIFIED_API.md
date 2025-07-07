# GraphQL UI Layout Unified API

A comprehensive unified API system that provides consistent interfaces across multiple backend services with automatic fallback mechanisms.

## Overview

The Unified API provides a single interface for common operations like search, pagination, authorization, caching, analytics, and more, with automatic backend detection and fallback mechanisms.

## Core Services

### Search Service

Provides unified search functionality across multiple backends.

```ruby
# Basic search
results = Zeropoint.search_service.search(Post, "rails")

# Advanced search with options
results = Zeropoint.search_service.search(Post, "rails", {
  include: [:user, :tags],
  limit: 20,
  offset: 0,
  search_type: "full_text"
})

# Service information
info = Zeropoint.search_service.info
# => { name: "PgSearchAdapter", available: true, healthy: true }
```

**Supported Backends:**
- `pg_search` (PostgreSQL full-text search)
- `searchkick` (Elasticsearch via Searchkick)
- `elasticsearch-model` (Direct Elasticsearch)
- Custom adapters

### Pagination Service

Provides unified pagination across multiple backends.

```ruby
# Basic pagination
paginated = Zeropoint.pagination_service.paginate(Post.all, 1, 12)

# With options
paginated = Zeropoint.pagination_service.paginate(Post.all, 1, 12, {
  total_count: true,
  metadata: true
})

# Service information
info = Zeropoint.pagination_service.info
```

**Supported Backends:**
- `kaminari` (Kaminari pagination)
- `will_paginate` (Will Paginate)
- Custom adapters

### Authorization Service

Provides unified authorization and permission checking.

```ruby
# Basic authorization
can_edit = Zeropoint.authorization_service.authorize?(current_user, :update, post)

# Multiple actions
permissions = Zeropoint.authorization_service.authorize_multiple(
  current_user, 
  [:read, :create, :update, :destroy], 
  post
)

# Service information
info = Zeropoint.authorization_service.info
```

**Supported Backends:**
- `pundit` (Pundit authorization)
- Custom permission checkers

### Cache Service

Provides unified caching across multiple backends.

```ruby
# Set cache
Zeropoint.cache_service.set('key', value, 3600)

# Get cache
value = Zeropoint.cache_service.get('key')

# Delete cache
Zeropoint.cache_service.delete('key')

# Clear all
Zeropoint.cache_service.clear

# Service information
info = Zeropoint.cache_service.info
```

**Supported Backends:**
- `redis` (Redis caching)
- `dalli` (Memcached)
- Rails cache store
- Custom adapters

### Analytics Service

Provides unified analytics tracking.

```ruby
# Track event
Zeropoint.analytics_service.track_event('post_viewed', {
  post_id: post.id,
  user_id: current_user&.id,
  page: request.path
}, current_user)

# Track page view
Zeropoint.analytics_service.track_page_view(request.path, {
  referrer: request.referrer,
  user_agent: request.user_agent
})

# Service information
info = Zeropoint.analytics_service.info
```

**Supported Backends:**
- `ahoy` (Ahoy analytics)
- `mixpanel` (Mixpanel)
- `google_analytics` (Google Analytics)
- Custom adapters

### File Storage Service

Provides unified file storage and management.

```ruby
# Upload file
file_info = Zeropoint.file_storage_service.upload(file, {
  folder: 'uploads',
  public: true
})

# Get file URL
url = Zeropoint.file_storage_service.url(file_info[:key])

# Delete file
Zeropoint.file_storage_service.delete(file_info[:key])

# Service information
info = Zeropoint.file_storage_service.info
```

**Supported Backends:**
- `carrierwave` (CarrierWave)
- `shrine` (Shrine)
- Custom adapters

### Notification Service

Provides unified notification system.

```ruby
# Send notification
Zeropoint.notification_service.notify(user, 'post_liked', {
  post_id: post.id,
  liker_id: current_user.id
})

# Get notifications
notifications = Zeropoint.notification_service.notifications_for(user)

# Mark as read
Zeropoint.notification_service.mark_as_read(notification)

# Service information
info = Zeropoint.notification_service.info
```

**Supported Backends:**
- `noticed` (Noticed notifications)
- `mailboxer` (Mailboxer)
- Custom adapters

## Rails 8 Authentication Integration

### User Model Setup

```ruby
class User < ApplicationRecord
  has_secure_password
  rolify
  
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  
  def admin?
    has_role?(:admin)
  end
  
  def confirmed?
    email_confirmed_at.present?
  end
end
```

### Authentication Controllers

```ruby
# Sessions Controller
class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:email], params[:password])
    
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Successfully signed in!'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end
end

# Registrations Controller
class RegistrationsController < ApplicationController
  def create
    @user = User.new(user_params)
    
    if @user.save
      @user.send_confirmation_email
      redirect_to login_path, notice: 'Account created!'
    else
      render :new
    end
  end
end
```

### Application Controller Integration

```ruby
class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?
  
  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def user_signed_in?
    current_user.present?
  end
  
  def authenticate_user!
    unless current_user
      redirect_to login_path, alert: 'Please sign in to continue.'
    end
  end
  
  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: 'Not authorized.'
    end
  end
end
```

## Dependency Container

### Overview

The dependency container manages service adapters with automatic detection and fallback mechanisms.

```ruby
container = Zeropoint::DependencyContainer.instance

# Get service
search_service = container.get_service(:search)

# Register custom adapter
container.register_adapter(:search, CustomSearchAdapter, priority: 10)

# Get adapter info
adapters_info = container.adapters_info
```

### Adapter Registration

```ruby
# High priority adapter (used first)
container.register_adapter(:search, ElasticsearchAdapter, priority: 10)

# Medium priority adapter (fallback)
container.register_adapter(:search, PgSearchAdapter, priority: 5)

# Low priority adapter (last resort)
container.register_adapter(:search, BasicSearchAdapter, priority: 1)
```

### Custom Adapter Example

```ruby
class CustomSearchAdapter < Zeropoint::Adapters::BaseAdapter
  def self.available?
    defined?(Elasticsearch) && Elasticsearch.ping
  end

  def search(model, query, options = {})
    model.search(query, options)
  end

  def info
    {
      name: 'CustomSearchAdapter',
      available: self.class.available?,
      healthy: Elasticsearch.ping,
      description: 'Custom Elasticsearch adapter'
    }
  end
end
```

## Configuration

### Service Configuration

```ruby
Zeropoint.configure do |config|
  # Enable features
  config.features = [
    :search,
    :pagination,
    :authorization,
    :cache,
    :analytics,
    :file_storage,
    :notifications
  ]
  
  # Service-specific configuration
  config.search = {
    default_search_type: "auto",
    min_query_length: 2,
    max_results: 100
  }
  
  config.pagination = {
    default_per_page: 12,
    max_per_page: 50
  }
  
  config.cache = {
    default_ttl: 3600,
    cache_prefix: "my_app"
  }
end
```

### Permission Configuration

```ruby
config.permission_checker = ->(user, action, resource) do
  return false unless user
  
  case action.to_sym
  when :read
    true
  when :create
    user.confirmed?
  when :update, :destroy
    user.admin? || resource.respond_to?(:user_id) && resource.user_id == user.id
  when :manage
    user.admin?
  else
    false
  end
end
```

## Health Checks

### System Health

```ruby
# Overall health check
health_data = Zeropoint.health_check

# Individual service health
search_health = Zeropoint.search_service.info
pagination_health = Zeropoint.pagination_service.info
cache_health = Zeropoint.cache_service.info
```

### Health Check Response

```json
{
  "status": "healthy",
  "timestamp": "2024-01-01T00:00:00Z",
  "services": {
    "search": {
      "status": "healthy",
      "adapter": "PgSearchAdapter",
      "available": true
    },
    "pagination": {
      "status": "healthy",
      "adapter": "KaminariAdapter",
      "available": true
    },
    "cache": {
      "status": "healthy",
      "adapter": "RedisAdapter",
      "available": true
    }
  },
  "adapters": {
    "search": ["PgSearchAdapter", "SearchkickAdapter"],
    "pagination": ["KaminariAdapter", "WillPaginateAdapter"],
    "cache": ["RedisAdapter", "DalliAdapter"]
  }
}
```

## Error Handling

### Service Errors

```ruby
begin
  results = Zeropoint.search_service.search(Post, "query")
rescue Zeropoint::ServiceError => e
  Rails.logger.error "Search service error: #{e.message}"
  # Fallback to basic search
  results = Post.where("title ILIKE ?", "%query%")
end
```

### Adapter Errors

```ruby
begin
  cached_value = Zeropoint.cache_service.get('key')
rescue Zeropoint::AdapterError => e
  Rails.logger.error "Cache adapter error: #{e.message}"
  # Fallback to Rails cache
  cached_value = Rails.cache.read('key')
end
```

## Testing

### Service Testing

```ruby
RSpec.describe Zeropoint::SearchService do
  it "provides search functionality" do
    results = Zeropoint.search_service.search(Post, "test")
    expect(results).to be_present
  end
  
  it "falls back to basic search when adapter fails" do
    allow_any_instance_of(PgSearchAdapter).to receive(:search).and_raise(StandardError)
    results = Zeropoint.search_service.search(Post, "test")
    expect(results).to be_present
  end
end
```

### Adapter Testing

```ruby
RSpec.describe CustomSearchAdapter do
  it "is available when Elasticsearch is running" do
    allow(Elasticsearch).to receive(:ping).and_return(true)
    expect(CustomSearchAdapter.available?).to be true
  end
  
  it "is not available when Elasticsearch is down" do
    allow(Elasticsearch).to receive(:ping).and_return(false)
    expect(CustomSearchAdapter.available?).to be false
  end
end
```

## Performance

### Caching Strategies

```ruby
# Cache service results
cached_results = Zeropoint.cache_service.get('search_results') do
  Zeropoint.search_service.search(Post, "query")
end

# Cache with TTL
Zeropoint.cache_service.set('expensive_operation', result, 3600)
```

### Monitoring

```ruby
# Track service performance
Zeropoint.analytics_service.track_event('service_performance', {
  service: 'search',
  duration: duration,
  query: query,
  results_count: results.count
})
```

## Best Practices

1. **Always provide fallbacks** for critical services
2. **Use appropriate priorities** when registering adapters
3. **Monitor service health** regularly
4. **Cache expensive operations** when possible
5. **Handle errors gracefully** with proper fallbacks
6. **Test all adapters** in your test suite
7. **Use Rails 8 authentication** for consistent user management
8. **Configure permissions** based on your application needs

## Migration Guide

### From Devise to Rails 8 Authentication

1. **Update Gemfile:**
```ruby
# Remove Devise
# gem 'devise'

# Add Rails 8 authentication
gem 'bcrypt'
```

2. **Update User model:**
```ruby
# Remove Devise modules
# devise :database_authenticatable, :registerable, ...

# Add Rails 8 authentication
has_secure_password
```

3. **Update controllers:**
```ruby
# Remove Devise helpers
# before_action :authenticate_user!

# Add Rails 8 helpers
before_action :authenticate_user!
helper_method :current_user, :user_signed_in?
```

4. **Update routes:**
```ruby
# Remove Devise routes
# devise_for :users

# Add Rails 8 routes
get 'signup', to: 'registrations#new'
post 'signup', to: 'registrations#create'
get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
delete 'logout', to: 'sessions#destroy'
```

5. **Update views:**
```erb
<!-- Remove Devise helpers -->
<!-- <%= link_to 'Sign out', destroy_user_session_path %> -->

<!-- Add Rails 8 helpers -->
<%= link_to 'Sign out', logout_path, method: :delete %>
```

## 🚀 Quick Start

### Installation

The unified API is automatically mounted when you install the GraphQL UI Layout gem:

```bash
# Add to Gemfile
gem 'zeropoint', path: '.'

# Install dependencies
bundle install

# Run the setup script
./setup.sh essential
```

### Access Points

- **API Base URL**: `http://localhost:3000/api/v1`
- **Swagger Documentation**: `http://localhost:3000/api/v1/swagger_doc`
- **Health Check**: `http://localhost:3000/api/v1/health`
- **API Docs Redirect**: `http://localhost:3000/api/docs`

## 📋 API Endpoints

### 1. GraphQL Endpoint (`/api/v1/graphql`)

**Purpose**: Execute GraphQL queries and access schema information

**Key Features**:
- Execute GraphQL queries
- Schema introspection
- Query validation
- Type and field discovery

**Example Usage**:
```bash
# Execute GraphQL query
curl -X POST http://localhost:3000/api/v1/graphql \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "query": "query { uiLayout { user { id email } navigation { items { label url } } } }"
  }'

# Get schema introspection
curl http://localhost:3000/api/v1/graphql/schema \
  -H "Authorization: Bearer YOUR_TOKEN"

# Get available types
curl http://localhost:3000/api/v1/graphql/types \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### 2. UI Layout Endpoint (`/api/v1/ui_layout`)

**Purpose**: Access UI layout data and configuration

**Key Features**:
- Complete UI layout data
- Navigation and sidebar data
- Content areas and widgets
- Theme and configuration management
- Offline data access

**Example Usage**:
```bash
# Get complete UI layout
curl http://localhost:3000/api/v1/ui_layout?page=home \
  -H "Authorization: Bearer YOUR_TOKEN"

# Get navigation data
curl http://localhost:3000/api/v1/ui_layout/navigation?page=posts \
  -H "Authorization: Bearer YOUR_TOKEN"

# Update theme configuration
curl -X PUT http://localhost:3000/api/v1/ui_layout/theme \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "theme": {
      "primary_color": "#667eea",
      "secondary_color": "#764ba2"
    }
  }'
```

### 3. Search Endpoint (`/api/v1/search`)

**Purpose**: Global search across all models with advanced filtering

**Key Features**:
- Global search across multiple models
- Model-specific search (posts, users, tags)
- Search suggestions and autocomplete
- Advanced filtering and pagination
- Search analytics and statistics

**Example Usage**:
```bash
# Global search
curl "http://localhost:3000/api/v1/search?query=rails&models[]=Post&models[]=User" \
  -H "Authorization: Bearer YOUR_TOKEN"

# Search posts with filters
curl "http://localhost:3000/api/v1/search/posts?query=graphql&tags[]=api&published=true" \
  -H "Authorization: Bearer YOUR_TOKEN"

# Get search suggestions
curl "http://localhost:3000/api/v1/search/suggestions?query=gra&limit=5" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### 4. File Management Endpoint (`/api/v1/files`)

**Purpose**: File upload, storage, and management

**Key Features**:
- File upload with categories and tags
- File listing and filtering
- Bulk upload operations
- File URL generation
- Storage statistics

**Example Usage**:
```bash
# Upload file
curl -X POST http://localhost:3000/api/v1/files \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -F "file=@document.pdf" \
  -F "category=documents" \
  -F "tags[]=important" \
  -F "tags[]=pdf"

# List files
curl "http://localhost:3000/api/v1/files?category=documents&page=1" \
  -H "Authorization: Bearer YOUR_TOKEN"

# Get file URL
curl http://localhost:3000/api/v1/files/123/url?expires_in=3600 \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### 5. Analytics Endpoint (`/api/v1/analytics`)

**Purpose**: Analytics and tracking data

**Key Features**:
- Page view analytics
- User activity tracking
- Search analytics
- File upload analytics
- User engagement metrics
- Custom event tracking

**Example Usage**:
```bash
# Get page views
curl "http://localhost:3000/api/v1/analytics/page_views?start_date=2024-01-01" \
  -H "Authorization: Bearer YOUR_TOKEN"

# Track custom event
curl -X POST http://localhost:3000/api/v1/analytics/track \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "event_name": "button_click",
    "properties": {
      "button_id": "submit_form",
      "page": "/contact"
    }
  }'

# Get dashboard statistics
curl http://localhost:3000/api/v1/analytics/dashboard \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### 6. Notifications Endpoint (`/api/v1/notifications`)

**Purpose**: User notifications and preferences

**Key Features**:
- User notification management
- Notification preferences
- Notification templates
- Test notification sending
- Notification statistics

**Example Usage**:
```bash
# Get user notifications
curl "http://localhost:3000/api/v1/notifications?page=1&read=false" \
  -H "Authorization: Bearer YOUR_TOKEN"

# Mark notification as read
curl -X PUT http://localhost:3000/api/v1/notifications/123/read \
  -H "Authorization: Bearer YOUR_TOKEN"

# Update notification preferences
curl -X PUT http://localhost:3000/api/v1/notifications/preferences \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "preferences": {
      "email": true,
      "push": false,
      "types": {
        "system": true,
        "posts": false
      }
    }
  }'
```

### 7. Cache Management Endpoint (`/api/v1/cache`)

**Purpose**: Cache management and monitoring

**Key Features**:
- Cache statistics and monitoring
- Cache key management
- Cache warming
- Performance metrics
- Configuration management

**Example Usage**:
```bash
# Get cache statistics
curl http://localhost:3000/api/v1/cache/stats \
  -H "Authorization: Bearer YOUR_TOKEN"

# Warm up cache
curl -X POST http://localhost:3000/api/v1/cache/warm_up \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "patterns": ["ui_layout_*", "navigation_*"]
  }'

# Clear cache by pattern
curl -X DELETE "http://localhost:3000/api/v1/cache/clear_pattern?pattern=ui_layout_*" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

## 🔐 Authentication

The unified API supports multiple authentication methods:

### Bearer Token Authentication (Recommended)
```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  http://localhost:3000/api/v1/ui_layout
```

### Basic Authentication
```bash
curl -u "user@example.com:password" \
  http://localhost:3000/api/v1/ui_layout
```

## 📊 Health Check

Monitor the API health:

```bash
curl http://localhost:3000/api/v1/health
```

Response:
```json
{
  "status": "healthy",
  "version": "1.0.0",
  "timestamp": "2024-01-15T10:30:00Z",
  "services": {
    "database": true,
    "redis": true,
    "elasticsearch": true,
    "sidekiq": true
  }
}
```

## 🛡️ Authorization

All endpoints use Pundit for authorization. Ensure your models have proper policies:

```ruby
# app/policies/ui_layout_policy.rb
class UiLayoutPolicy < ApplicationPolicy
  def read?
    user.present?
  end

  def update?
    user.admin?
  end
end
```

## 📈 Rate Limiting

Rate limiting is applied using Rack Attack:

```ruby
# config/initializers/rack_attack.rb
class Rack::Attack
  throttle('api/ip', limit: 300, period: 5.minutes) do |req|
    req.ip if req.path.start_with?('/api/')
  end

  throttle('api/user', limit: 1000, period: 5.minutes) do |req|
    req.env['warden'].user&.id if req.path.start_with?('/api/')
  end
end
```

## 🔧 Configuration

Configure the API in your Rails application:

```ruby
# config/initializers/zeropoint.rb
Zeropoint.configure do |config|
  # API configuration
  config.api_config = {
    rate_limit: {
      requests_per_minute: 1000,
      burst_limit: 100
    },
    authentication: {
      methods: [:token, :basic],
      token_expiry: 24.hours
    },
    documentation: {
      enabled: true,
      contact_email: 'api@example.com'
    }
  }
end
```

## 🧪 Testing

Test the API endpoints:

```ruby
# spec/requests/api/unified_api_spec.rb
require 'rails_helper'

RSpec.describe 'Unified API', type: :request do
  let(:user) { create(:user) }
  let(:token) { user.generate_jwt }

  describe 'GET /api/v1/health' do
    it 'returns health status' do
      get '/api/v1/health'
      expect(response).to have_http_status(:ok)
      expect(json_response['status']).to eq('healthy')
    end
  end

  describe 'GET /api/v1/ui_layout' do
    it 'returns UI layout data' do
      get '/api/v1/ui_layout', headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(json_response['layout']).to be_present
    end
  end
end
```

## 🚀 Deployment

### Production Configuration

```ruby
# config/environments/production.rb
Rails.application.configure do
  # API configuration
  config.zeropoint.api = {
    rate_limit: {
      requests_per_minute: 500,
      burst_limit: 50
    },
    cache: {
      enabled: true,
      store: :redis_cache_store,
      url: ENV['REDIS_URL']
    },
    monitoring: {
      enabled: true,
      sentry_dsn: ENV['SENTRY_DSN']
    }
  }
end
```

### Environment Variables

```bash
# .env
API_RATE_LIMIT=1000
API_BURST_LIMIT=100
REDIS_URL=redis://localhost:6379/0
SENTRY_DSN=your_sentry_dsn
```

## 📚 Integration Examples

### Frontend Integration

```javascript
// JavaScript client
class ZeropointAPI {
  constructor(baseURL, token) {
    this.baseURL = baseURL;
    this.token = token;
  }

  async getUILayout(page = 'home') {
    const response = await fetch(`${this.baseURL}/ui_layout?page=${page}`, {
      headers: {
        'Authorization': `Bearer ${this.token}`,
        'Content-Type': 'application/json'
      }
    });
    return response.json();
  }

  async search(query, models = []) {
    const params = new URLSearchParams({ query, ...models.map(m => ['models[]', m]) });
    const response = await fetch(`${this.baseURL}/search?${params}`, {
      headers: {
        'Authorization': `Bearer ${this.token}`,
        'Content-Type': 'application/json'
      }
    });
    return response.json();
  }
}

// Usage
const api = new ZeropointAPI('http://localhost:3000/api/v1', 'your_token');
const layout = await api.getUILayout('posts');
const searchResults = await api.search('graphql', ['Post', 'User']);
```

### Mobile App Integration

```swift
// Swift client
class ZeropointAPI {
    let baseURL: String
    let token: String
    
    init(baseURL: String, token: String) {
        self.baseURL = baseURL
        self.token = token
    }
    
    func getUILayout(page: String = "home") async throws -> UILayoutResponse {
        let url = URL(string: "\(baseURL)/ui_layout?page=\(page)")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(UILayoutResponse.self, from: data)
    }
}
```

## 🔍 Monitoring and Debugging

### API Logs

```ruby
# config/initializers/zeropoint.rb
Zeropoint.configure do |config|
  config.api_config = {
    logging: {
      enabled: true,
      level: :info,
      format: :json
    }
  }
end
```

### Performance Monitoring

```ruby
# Monitor API performance
Zeropoint::Api.statistics
# => {
#   total_endpoints: 7,
#   version: "1.0.0",
#   documentation_url: "/api/v1/swagger_doc",
#   health_check_url: "/api/v1/health"
# }
```

## 🆘 Troubleshooting

### Common Issues

1. **Authentication Errors**
   ```bash
   # Check token validity
   curl -H "Authorization: Bearer YOUR_TOKEN" \
     http://localhost:3000/api/v1/health
   ```

2. **Rate Limiting**
   ```bash
   # Check rate limit headers
   curl -I http://localhost:3000/api/v1/ui_layout \
     -H "Authorization: Bearer YOUR_TOKEN"
   ```

3. **Service Health**
   ```bash
   # Check all services
   curl http://localhost:3000/api/v1/health
   ```

### Debug Mode

Enable debug mode for detailed error messages:

```ruby
# config/environments/development.rb
Rails.application.configure do
  config.zeropoint.api = {
    debug: true,
    verbose_logging: true
  }
end
```

## 📖 Additional Resources

- [GraphQL UI Layout Gem Documentation](README.md)
- [Gem Bundles Documentation](GEM_BUNDLES.md)
- [API Swagger Documentation](http://localhost:3000/api/v1/swagger_doc)
- [GitHub Repository](https://github.com/ceccec/zeropoint)

---

The unified API provides a comprehensive interface to all the functionality provided by the GraphQL UI Layout gem and its related gems, making it easy to build modern, scalable applications with a single API endpoint. 