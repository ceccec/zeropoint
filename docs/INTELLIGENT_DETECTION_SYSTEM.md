# Zeropoint Intelligent Detection System

## Overview

The Zeropoint Rails application includes a comprehensive intelligent detection system that automatically configures features based on your project structure, available gems, database capabilities, and route patterns. This creates a self-configuring, intelligent Rails application that adapts to your specific setup.

## 🧠 How It Works

The intelligent detection system runs during Rails initialization and automatically:

1. **Analyzes your routes** to detect patterns and configure appropriate middleware
2. **Detects your database** and enables relevant features
3. **Scans for available gems** and configures features accordingly
4. **Identifies development tools** and sets them up automatically
5. **Determines API vs Full-stack mode** based on route configuration

## 🔍 Detection Categories

### 1. Route Pattern Detection

The system analyzes your `config/routes.rb` to detect patterns and configure middleware:

#### API Routes
```ruby
# Detects routes starting with /api/ or /zeropoint
post '/zeropoint', to: 'zeropoint/gateway#execute'
namespace :api do
  resources :users
end
```
**Auto-enables:**
- CORS middleware for cross-origin requests
- API-specific optimizations

#### HTML Routes
```ruby
# Detects root route or routes with .html/.erb patterns
root 'pages#index'
get '/about', to: 'pages#about'
```
**Auto-enables:**
- Compression middleware (Rack::Deflater)
- HTML-specific optimizations

#### Locale Routes
```ruby
# Detects routes with locale parameters
scope ':locale' do
  resources :posts
end
```
**Auto-prepares:**
- Language detection middleware
- Internationalization features

#### Session Routes
```ruby
# Detects authentication/session routes
get '/login', to: 'sessions#new'
post '/logout', to: 'sessions#destroy'
```
**Auto-enables:**
- Session middleware
- Cookie handling

#### Admin Routes
```ruby
# Detects admin functionality
namespace :admin do
  resources :users
end
```
**Auto-prepares:**
- Admin-specific configurations
- Authorization middleware

#### GraphQL Routes
```ruby
# Detects GraphQL endpoints
post '/graphql', to: 'graphql#execute'
```
**Auto-enables:**
- GraphQL-specific optimizations
- Query parsing middleware

### 2. Database Feature Detection

Automatically detects your database adapter and enables relevant features:

#### PostgreSQL
```ruby
# Detected automatically when using PostgreSQL
config.zeropoint_features[:full_text_search] = true
config.zeropoint_features[:json_queries] = true
config.zeropoint_features[:trigram_similarity] = true
```

#### MySQL
```ruby
# Detected automatically when using MySQL
config.zeropoint_features[:full_text_search] = true
config.zeropoint_features[:json_queries] = true
```

#### SQLite
```ruby
# Detected automatically when using SQLite
config.zeropoint_features[:full_text_search] = false
config.zeropoint_features[:json_queries] = false
```

### 3. Gem Availability Detection

Scans for available gems and configures features:

#### Search & Caching
```ruby
# Elasticsearch detection
if defined?(Elasticsearch::Model)
  config.zeropoint_features[:search] = true
end

# Redis detection
if defined?(Redis)
  config.zeropoint_features[:caching] = true
end
```

#### Background Processing
```ruby
# Sidekiq detection
if defined?(Sidekiq)
  config.zeropoint_features[:background_jobs] = true
end
```

#### API & Testing
```ruby
# GraphQL detection
if defined?(GraphQL)
  config.zeropoint_features[:api_graphql] = true
end

# Testing tools detection
if defined?(RSpec)
  config.zeropoint_features[:testing] = true
end
```

### 4. Development Tools Detection

Automatically configures development tools when available:

#### Code Quality
```ruby
# RuboCop detection
if defined?(RuboCop)
  config.zeropoint_features[:code_quality] = true
end
```

#### Development Helpers
```ruby
# BetterErrors detection
if defined?(BetterErrors)
  config.middleware.use BetterErrors::Middleware
end

# Bullet detection (N+1 queries)
if defined?(Bullet)
  Bullet.enable = true
  Bullet.rails_logger = true
end
```

### 5. API-only Mode Detection

Intelligent detection of API-only vs Full-stack mode:

```ruby
# Automatic detection based on root_path
config.api_only = ENV['ZEROPOINT_API_ONLY'] == 'true' || !defined_root_path?

# Manual override
ZEROPOINT_API_ONLY=true rails server
```

## 📊 Configuration Summary

The system logs a comprehensive summary of all detected features:

```
🧠 Zeropoint Intelligent Configuration Summary:
   API Mode: Full-stack
   Database Features: Full-text search
   Available Gems: redis, sidekiq, graphql, rubocop, rspec
   Route Patterns: api_routes, html_routes, session_routes
   Development Tools: better_errors, bullet, spring
```

## 🚀 Benefits

### 1. Zero Configuration
- No manual setup required for common features
- Automatically adapts to your project structure
- Reduces boilerplate configuration

### 2. Intelligent Optimization
- Enables only necessary middleware
- Configures database-specific features
- Optimizes for your specific use case

### 3. Development Experience
- Auto-configures development tools
- Provides helpful logging and feedback
- Maintains consistency across environments

### 4. Production Ready
- Optimizes for production environments
- Enables appropriate security features
- Configures performance optimizations

## 🔧 Customization

### Manual Override
You can manually override any auto-detected feature:

```ruby
# In config/application.rb
config.zeropoint_features[:full_text_search] = false  # Override database detection
config.zeropoint_features[:caching] = false           # Override gem detection
```

### Environment-Specific Configuration
```ruby
# In config/environments/production.rb
config.zeropoint_features[:development_tools] = false
config.zeropoint_features[:debug_logging] = false
```

### Custom Detection Rules
Add your own detection logic:

```ruby
# In config/application.rb
def self.custom_feature_detection
  # Your custom detection logic
  config.zeropoint_features[:custom_feature] = detect_custom_feature?
end
```

## 📝 Logging

The system provides detailed logging of all detection and configuration activities:

```
🌐 Auto-enabled CORS for API routes
🗜️ Auto-enabled compression for HTML routes
🌍 Auto-detected locale routes for language middleware
🍪 Auto-enabled session middleware
🐘 Auto-enabled PostgreSQL features: full-text search, JSON queries, trigram similarity
💎 Auto-detected gems: redis, sidekiq, graphql, rubocop, rspec
🛣️ Auto-detected route patterns: api_routes, html_routes, session_routes
🔧 Auto-configured development tools
```

## 🎯 Best Practices

### 1. Route Organization
Organize your routes to help the detection system:

```ruby
# Clear API routes
namespace :api do
  resources :users
end

# Clear admin routes
namespace :admin do
  resources :dashboard
end

# Clear locale routes
scope ':locale' do
  resources :posts
end
```

### 2. Gem Management
Use consistent gem naming to help detection:

```ruby
# Standard gems for better detection
gem 'redis'
gem 'sidekiq'
gem 'graphql'
gem 'rubocop'
gem 'rspec-rails'
```

### 3. Database Configuration
Use standard database adapters for automatic feature detection:

```ruby
# PostgreSQL for full feature set
gem 'pg'

# MySQL for basic features
gem 'mysql2'

# SQLite for development
gem 'sqlite3'
```

## 🔮 Future Enhancements

The intelligent detection system is designed to be extensible:

### Planned Features
- **Machine Learning Integration**: Learn from usage patterns
- **Performance Optimization**: Auto-tune based on load patterns
- **Security Detection**: Auto-enable security features based on routes
- **Deployment Detection**: Auto-configure for different deployment environments
- **Team Pattern Learning**: Learn from team development patterns

### Custom Extensions
```ruby
# Add custom detection rules
Zeropoint::IntelligentDetection.register_detector(:custom_feature) do
  # Your detection logic
end
```

## 📚 Related Documentation

- [API-only Mode Configuration](./API_ONLY_MODE.md)
- [Rails Best Practices](./RAILS_BEST_PRACTICES.md)
- [Uroboros Best Practices](./UROBOROS_BEST_PRACTICES.md)
- [Configuration Guide](./CONFIGURATION_GUIDE.md)

---

*The Zeropoint Intelligent Detection System makes your Rails application self-configuring, intelligent, and adaptive to your specific project needs.* 