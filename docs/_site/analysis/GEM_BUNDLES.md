# GraphQL UI Layout Gem Bundles

This repository includes comprehensive gem bundles designed to work seamlessly with the GraphQL UI Layout gem. These bundles provide all the necessary dependencies for building modern, scalable Rails applications.

## Bundle Options

### 1. Complete Bundle (`Gemfile`)
**For:** Large-scale applications with advanced features
**Use when:** You need comprehensive functionality including e-commerce, analytics, social features, and advanced monitoring.

**Key Features:**
- Full GraphQL ecosystem with batch loading and caching
- Multiple authentication providers (OAuth, social logins)
- Advanced search with Elasticsearch
- E-commerce capabilities (Stripe, Spree/Solidus)
- Comprehensive monitoring and analytics
- Social media integration
- Advanced deployment tools

### 2. Essential Bundle (`Gemfile.essential`)
**For:** Standard business applications
**Use when:** You need core functionality without the complexity of advanced features.

**Key Features:**
- Core GraphQL functionality
- Standard authentication and authorization
- Basic search and filtering
- File upload and storage
- Background job processing
- Error tracking and logging
- Testing and code quality tools

## Quick Start

### Using the Essential Bundle

1. **Copy the essential bundle:**
   ```bash
   cp Gemfile.essential Gemfile
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Set up the GraphQL UI Layout gem:**
   ```bash
   rails generate zeropoint:install
   ```

4. **Configure the gem:**
   ```ruby
   # config/initializers/zeropoint.rb
   Zeropoint.configure do |config|
     config.features = [:navigation, :sidebar, :content_areas, :widgets, :actions, :offline]
     
     config.theme = {
       primary_color: "#667eea",
       secondary_color: "#764ba2",
       # ... more theme options
     }
   end
   ```

### Using the Complete Bundle

1. **Use the complete bundle:**
   ```bash
   # The complete Gemfile is already in place
   bundle install
   ```

2. **Set up additional services:**
   ```bash
   # Redis for caching and Sidekiq
   brew install redis
   
   # PostgreSQL for database
   brew install postgresql
   
   # Elasticsearch for advanced search
   brew install elasticsearch
   ```

## Bundle Categories

### Core Dependencies
These gems are essential for the GraphQL UI Layout system:

- **Rails 7.1+**: Modern Rails with Hotwire
- **GraphQL 2.0+**: GraphQL schema and queries
- **Stimulus**: Modern JavaScript framework
- **Devise**: Authentication system
- **Pundit**: Authorization policies
- **Rolify**: Role management

### UI & Frontend
Enhance the user interface:

- **ViewComponent**: Reusable UI components
- **Tailwind CSS**: Utility-first CSS framework
- **Font Awesome**: Icon library
- **Turbo**: Single-page application feel

### Performance & Caching
Optimize application performance:

- **Redis**: In-memory data store
- **Sidekiq**: Background job processing
- **Bullet**: N+1 query detection
- **Rack Attack**: Rate limiting

### Search & Filtering
Advanced search capabilities:

- **PgSearch**: PostgreSQL full-text search
- **Ransack**: Search and filtering
- **Elasticsearch**: Advanced search engine
- **ActsAsTaggableOn**: Tagging system

### File Management
Handle file uploads and storage:

- **CarrierWave**: File uploads
- **AWS SDK**: Cloud storage
- **ImageProcessing**: Image manipulation
- **MiniMagick**: Image processing

### Monitoring & Security
Production-ready monitoring:

- **Sentry**: Error tracking
- **Brakeman**: Security scanning
- **Lograge**: Structured logging
- **Strong Migrations**: Safe database changes

## Configuration Examples

### Basic Configuration
```ruby
# config/initializers/zeropoint.rb
Zeropoint.configure do |config|
  config.features = [:navigation, :sidebar, :content_areas, :widgets, :actions, :offline]
  
  config.theme = {
    primary_color: "#667eea",
    secondary_color: "#764ba2",
    accent_color: "#007bff",
    font_family: "system-ui, -apple-system, sans-serif"
  }
  
  config.app_config = {
    app_name: "My Application",
    app_version: "1.0.0",
    default_locale: "en"
  }
end
```

### Advanced Configuration
```ruby
# config/initializers/zeropoint.rb
Zeropoint.configure do |config|
  # Enable all features
  config.features = [:navigation, :sidebar, :content_areas, :widgets, :actions, :offline]
  
  # Custom permission checker
  config.permission_checker = ->(user, action, resource) {
    user&.has_permission?(action, resource)
  }
  
  # Custom theme
  config.theme = {
    primary_color: "#667eea",
    secondary_color: "#764ba2",
    accent_color: "#007bff",
    success_color: "#28a745",
    warning_color: "#ffc107",
    danger_color: "#dc3545",
    info_color: "#17a2b8",
    light_color: "#f8f9fa",
    dark_color: "#343a40",
    font_family: "Inter, system-ui, sans-serif",
    border_radius: "12px",
    box_shadow: "0 4px 6px rgba(0,0,0,0.1)",
    transition: "all 0.3s cubic-bezier(0.4, 0, 0.2, 1)"
  }
  
  # App configuration
  config.app_config = {
    app_name: "Enterprise Dashboard",
    app_version: "2.1.0",
    api_version: "v2",
    default_locale: "en",
    supported_locales: ["en", "es", "fr"],
    timezone: "UTC",
    date_format: "%Y-%m-%d",
    time_format: "%H:%M:%S",
    pagination: {
      default_per_page: 25,
      max_per_page: 100
    },
    search: {
      default_search_type: "full_text",
      min_query_length: 2,
      max_suggestions: 15
    },
    cache: {
      default_ttl: 3600,
      max_ttl: 86400
    },
    offline: {
      enabled: true,
      max_cache_size: "100MB",
      sync_interval: 300
    }
  }
end
```

## Integration with Other Gems

### Authentication Integration
```ruby
# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  rolify
  acts_as_taggable_on :skills, :interests
  
  def can?(action, resource)
    # Custom permission logic
    roles.any? { |role| role.permissions.include?("#{action}_#{resource}") }
  end
end
```

### GraphQL Schema Integration
```ruby
# app/graphql/types/query_type.rb
class Types::QueryType < Types::BaseObject
  field :ui_layout, Types::UiLayoutType, null: false do
    argument :page, String, required: false
  end
  
  def ui_layout(page: "home")
    # The GraphQL UI Layout gem handles this
    Zeropoint::Graphql::Resolvers::UiLayoutResolver.new(
      object: nil, 
      context: context, 
      field: nil
    ).resolve(page: page)
  end
end
```

### View Component Integration
```ruby
# app/components/ui/navigation_component.rb
class Ui::NavigationComponent < ViewComponent::Base
  def initialize(user:, current_page:)
    @user = user
    @current_page = current_page
  end
  
  def navigation_data
    Zeropoint.build_navigation(@user, { current_page: @current_page })
  end
end
```

## Deployment Considerations

### Environment Variables
```bash
# .env
DATABASE_URL=postgresql://user:password@localhost/myapp
REDIS_URL=redis://localhost:6379/0
ELASTICSEARCH_URL=http://localhost:9200
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_REGION=us-east-1
SENTRY_DSN=your_sentry_dsn
```

### Production Configuration
```ruby
# config/environments/production.rb
Rails.application.configure do
  # Cache store
  config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }
  
  # Background jobs
  config.active_job.queue_adapter = :sidekiq
  
  # Asset hosting
  config.action_controller.asset_host = ENV['CDN_HOST']
  
  # Logging
  config.log_level = :info
  config.log_tags = [:request_id, :remote_ip]
end
```

## Troubleshooting

### Common Issues

1. **GraphQL Schema Loading**
   ```ruby
   # Ensure GraphQL types are loaded
   Rails.application.config.autoload_paths += Dir[Rails.root.join('app', 'graphql', '**', '*.rb')]
   ```

2. **Stimulus Controller Loading**
   ```javascript
   // Ensure Stimulus controllers are registered
   import { Application } from "@hotwired/stimulus"
   import UiLayoutController from "./ui_layout_controller"
   
   const application = Application.start()
   application.register("ui-layout", UiLayoutController)
   ```

3. **Permission System**
   ```ruby
   # Ensure user model has required methods
   class User < ApplicationRecord
     def can?(action, resource)
       # Implement your permission logic
       roles.any? { |role| role.permissions.include?("#{action}_#{resource}") }
     end
   end
   ```

## Support

For issues with the GraphQL UI Layout gem:
- Check the [main README](README.md)
- Review the [changelog](CHANGELOG.md)
- Open an issue on GitHub

For issues with bundled gems:
- Check individual gem documentation
- Review gem-specific GitHub repositories 