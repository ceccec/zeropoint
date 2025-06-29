# GraphQL UI Layout Demo Application

A comprehensive demo application showcasing all features of the GraphQL UI Layout gem with Rails 8 authentication.

## Features Demonstrated

### 🔐 Rails 8 Authentication
- Built-in authentication with bcrypt password hashing
- User registration with email confirmation
- Password reset functionality
- Session-based authentication
- Role-based permissions (admin, moderator, user)

### 🎨 GraphQL UI Layout Integration
- Dynamic navigation system
- Configurable sidebars with widgets
- Theme customization
- Permission-driven interfaces
- Offline-capable functionality

### 🔍 Search & Pagination
- Multiple search backends (pg_search, searchkick, elasticsearch)
- Automatic backend detection with fallbacks
- Custom search adapters
- Pagination with multiple backends (kaminari, will_paginate)

### 🛡️ Authorization & Permissions
- Role-based access control with Rolify
- Pundit integration
- Custom permission checkers
- Resource-level permissions

### 📊 Analytics & Caching
- Multiple analytics backends (ahoy, mixpanel, google_analytics)
- Redis and Memcached caching
- Performance monitoring
- Event tracking

### 📁 File Storage & Notifications
- CarrierWave and Shrine integration
- Noticed and Mailboxer notifications
- File upload management

## Quick Start

### Prerequisites
- Ruby 3.0+
- PostgreSQL
- Redis (optional, for caching)
- Node.js (for TypeScript client)

### Installation

1. **Clone and setup the main gem:**
```bash
cd zeropoint
bundle install
```

2. **Setup the demo app:**
```bash
cd demo_app
bundle install
rails db:create db:migrate db:seed
rails server
```

3. **Visit the application:**
- Main app: http://localhost:3000
- GraphQL UI Layout: http://localhost:3000/zeropoint
- Health check: http://localhost:3000/health

### Default Users

The demo app comes with pre-seeded users:

- **Admin**: `admin@example.com` / `password`
- **Users**: `user1@example.com` through `user5@example.com` / `password`

## Demo Features

### 🏠 Home Page (`/`)
- Recent posts display
- Trending posts
- Active users list
- Search functionality
- GraphQL UI Layout integration

### 🔍 Search Demo (`/search?q=rails`)
- Real-time search results
- Multiple search backend testing
- Analytics tracking
- Pagination examples

### 🏥 Health Check (`/health`)
- System health status
- Available adapters
- Service information
- Performance metrics

### 🛠️ Services Demo (`/services_demo`)
- Search service demonstration
- Pagination service examples
- Authorization testing
- Cache functionality
- Analytics tracking

### 🔧 Adapters Demo (`/adapters_demo`)
- Available adapters list
- Priority configurations
- Fallback mechanisms
- Custom adapter examples

### ⚡ Performance Demo (`/performance_demo`)
- Caching demonstrations
- Performance metrics
- Memory usage tracking
- Database query optimization

## API Endpoints

### REST API (`/api/v1/`)

```bash
# Posts
GET    /api/v1/posts
GET    /api/v1/posts/:id
POST   /api/v1/posts
PUT    /api/v1/posts/:id
DELETE /api/v1/posts/:id

# Users
GET    /api/v1/users
GET    /api/v1/users/:id

# Health
GET    /api/v1/health
```

### GraphQL UI Layout (`/zeropoint`)

```graphql
query {
  uiLayout {
    navigation {
      items {
        label
        url
        icon
      }
    }
    sidebar {
      widgets {
        type
        title
        content
      }
    }
    theme {
      primaryColor
      fontFamily
    }
  }
}
```

## Admin Interface

### Dashboard (`/admin`)
- User statistics
- Post analytics
- System overview
- Performance metrics

### User Management (`/admin/users`)
- User listing
- Role management
- Profile editing
- Account administration

### Post Management (`/admin/posts`)
- Post listing
- Status management
- Content editing
- Tag management

### Analytics (`/admin/analytics`)
- User activity
- Post performance
- Search analytics
- System metrics

## Configuration Examples

### Custom Adapters

```ruby
# config/initializers/custom_adapters.rb
module DemoApp
  module Adapters
    class CustomSearchAdapter < Zeropoint::Adapters::BaseAdapter
      def search(model, query, options = {})
        model.where("title ILIKE :query OR content ILIKE :query", query: "%#{query}%")
      end
    end
  end
end

# Register with high priority
Zeropoint::DependencyContainer.instance.register_adapter(
  :search, 
  DemoApp::Adapters::CustomSearchAdapter, 
  priority: 10
)
```

### Theme Customization

```ruby
# config/initializers/zeropoint.rb
Zeropoint.configure do |config|
  config.theme = {
    primary_color: "#3b82f6",
    secondary_color: "#8b5cf6",
    font_family: "Inter, system-ui, sans-serif",
    border_radius: "12px"
  }
end
```

### Permission System

```ruby
# Custom permission checker
config.permission_checker = ->(user, action, resource) do
  case action.to_sym
  when :read
    true
  when :create
    user.confirmed?
  when :update, :destroy
    user.admin? || resource.user_id == user.id
  when :manage
    user.admin?
  end
end
```

## Testing

### Running Tests

```bash
cd demo_app
bundle exec rspec
```

### Test Coverage

The demo app includes comprehensive tests:
- Model specs for all entities
- Factory definitions
- Service integration tests
- API endpoint tests

### Example Test

```ruby
RSpec.describe "GraphQL UI Layout Integration" do
  it "provides search functionality" do
    results = Zeropoint.search_service.search(Post, "rails")
    expect(results).to be_present
  end

  it "provides pagination" do
    paginated = Zeropoint.pagination_service.paginate(Post.all, 1, 10)
    expect(paginated).to respond_to(:current_page)
  end
end
```

## Development

### Adding New Features

1. **Create models and migrations:**
```bash
rails generate model NewFeature name:string
rails db:migrate
```

2. **Add to GraphQL UI Layout:**
```ruby
# Register with dependency container
Zeropoint::DependencyContainer.instance.register_adapter(
  :new_feature, 
  NewFeatureAdapter
)
```

3. **Update configuration:**
```ruby
# config/initializers/zeropoint.rb
config.features << :new_feature
```

### Debugging

```ruby
# Check available adapters
Zeropoint::DependencyContainer.instance.adapters_info

# Test service health
Zeropoint.search_service.info
Zeropoint.pagination_service.info

# Check configuration
Zeropoint.configuration
```

## Troubleshooting

### Common Issues

1. **Database connection errors:**
```bash
rails db:create db:migrate
```

2. **Missing dependencies:**
```bash
bundle install
```

3. **Redis connection (optional):**
```bash
# Install Redis or comment out Redis gems in Gemfile
```

4. **Permission errors:**
```bash
# Check user roles in Rails console
rails console
User.first.add_role(:admin)
```

### Health Check

Visit `/health` to see:
- System status
- Available adapters
- Service health
- Configuration details

### Logs

```bash
# View application logs
tail -f log/development.log

# View GraphQL UI Layout logs
grep "GraphQL UI Layout" log/development.log
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes in the demo app
4. Test thoroughly
5. Submit a pull request

## License

This demo application is part of the GraphQL UI Layout project and is licensed under the MIT License.

---

**Happy coding! 🎉** 