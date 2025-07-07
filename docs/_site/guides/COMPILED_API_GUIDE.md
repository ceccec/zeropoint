# GraphQL UI Layout API Guide

A comprehensive guide to all APIs, services, and integration points in the GraphQL UI Layout gem.

## Table of Contents

1. [Core Services API](#core-services-api)
2. [GraphQL Schema](#graphql-schema)
3. [Rails 8 Authentication API](#rails-8-authentication-api)
4. [REST API Endpoints](#rest-api-endpoints)
5. [TypeScript Client API](#typescript-client-api)
6. [Configuration API](#configuration-api)
7. [Health Check API](#health-check-api)
8. [Error Handling](#error-handling)

## Core Services API

### Search Service

```ruby
# Basic search
Zeropoint.search_service.search(model, query, options = {})

# Examples
results = Zeropoint.search_service.search(Post, "rails")
results = Zeropoint.search_service.search(User, "john", { limit: 10 })

# Options
{
  include: [:user, :tags],     # Include associations
  limit: 20,                   # Maximum results
  offset: 0,                   # Offset for pagination
  search_type: "full_text",    # Search type
  fields: ["title", "content"] # Specific fields
}

# Service info
Zeropoint.search_service.info
# => { name: "PgSearchAdapter", available: true, healthy: true }
```

### Pagination Service

```ruby
# Basic pagination
Zeropoint.pagination_service.paginate(collection, page, per_page, options = {})

# Examples
paginated = Zeropoint.pagination_service.paginate(Post.all, 1, 12)
paginated = Zeropoint.pagination_service.paginate(User.active, 2, 20)

# Options
{
  total_count: true,    # Include total count
  metadata: true,       # Include pagination metadata
  max_per_page: 50      # Maximum per page
}

# Service info
Zeropoint.pagination_service.info
```

### Authorization Service

```ruby
# Basic authorization
Zeropoint.authorization_service.authorize?(user, action, resource)

# Examples
can_edit = Zeropoint.authorization_service.authorize?(current_user, :update, post)
can_create = Zeropoint.authorization_service.authorize?(current_user, :create, Post)

# Multiple actions
permissions = Zeropoint.authorization_service.authorize_multiple(
  current_user, 
  [:read, :create, :update, :destroy], 
  post
)

# Service info
Zeropoint.authorization_service.info
```

### Cache Service

```ruby
# Set cache
Zeropoint.cache_service.set(key, value, ttl = nil)

# Get cache
value = Zeropoint.cache_service.get(key)

# Delete cache
Zeropoint.cache_service.delete(key)

# Clear all
Zeropoint.cache_service.clear

# Examples
Zeropoint.cache_service.set('user:123', user_data, 3600)
cached_user = Zeropoint.cache_service.get('user:123')

# Service info
Zeropoint.cache_service.info
```

### Analytics Service

```ruby
# Track event
Zeropoint.analytics_service.track_event(event_name, properties = {}, user = nil)

# Track page view
Zeropoint.analytics_service.track_page_view(page, properties = {})

# Examples
Zeropoint.analytics_service.track_event('post_viewed', {
  post_id: post.id,
  user_id: current_user&.id
}, current_user)

Zeropoint.analytics_service.track_page_view('/posts', {
  referrer: request.referrer
})

# Service info
Zeropoint.analytics_service.info
```

### File Storage Service

```ruby
# Upload file
Zeropoint.file_storage_service.upload(file, options = {})

# Get file URL
Zeropoint.file_storage_service.url(key)

# Delete file
Zeropoint.file_storage_service.delete(key)

# Examples
file_info = Zeropoint.file_storage_service.upload(uploaded_file, {
  folder: 'uploads',
  public: true
})

url = Zeropoint.file_storage_service.url(file_info[:key])

# Service info
Zeropoint.file_storage_service.info
```

### Notification Service

```ruby
# Send notification
Zeropoint.notification_service.notify(user, notification_type, data = {})

# Get notifications
Zeropoint.notification_service.notifications_for(user)

# Mark as read
Zeropoint.notification_service.mark_as_read(notification)

# Examples
Zeropoint.notification_service.notify(user, 'post_liked', {
  post_id: post.id,
  liker_id: current_user.id
})

notifications = Zeropoint.notification_service.notifications_for(current_user)

# Service info
Zeropoint.notification_service.info
```

## GraphQL Schema

### UI Layout Query

```graphql
query {
  uiLayout {
    navigation {
      items {
        id
        label
        url
        icon
        children {
          id
          label
          url
          icon
        }
      }
    }
    sidebar {
      widgets {
        id
        type
        title
        content
        actions {
          label
          url
          method
        }
      }
    }
    theme {
      primaryColor
      secondaryColor
      accentColor
      fontFamily
      borderRadius
      boxShadow
      transition
    }
    permissions {
      canRead
      canCreate
      canUpdate
      canDelete
      canManage
    }
    offlineData {
      enabled
      maxCacheSize
      syncInterval
    }
  }
}
```

### Search Query

```graphql
query SearchPosts($query: String!, $page: Int, $perPage: Int) {
  searchPosts(query: $query, page: $page, perPage: $perPage) {
    results {
      id
      title
      content
      user {
        id
        username
      }
      tags
    }
    pagination {
      currentPage
      totalPages
      totalCount
      perPage
    }
  }
}
```

### User Query

```graphql
query GetUser($id: ID!) {
  user(id: $id) {
    id
    username
    email
    firstName
    lastName
    bio
    avatarUrl
    roles
    posts {
      id
      title
      status
    }
    followers {
      id
      username
    }
    following {
      id
      username
    }
  }
}
```

## Rails 8 Authentication API

### User Model

```ruby
class User < ApplicationRecord
  has_secure_password
  rolify
  
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  
  # Authentication methods
  def self.authenticate(email, password)
    user = find_by(email: email)
    user&.authenticate(password)
  end
  
  def confirm_email!
    update!(email_confirmed_at: Time.current)
  end
  
  def confirmed?
    email_confirmed_at.present?
  end
  
  def admin?
    has_role?(:admin)
  end
end
```

### Application Controller

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

### Sessions Controller

```ruby
class SessionsController < ApplicationController
  def new
    redirect_to root_path if current_user
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Successfully signed in!'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Successfully signed out!'
  end
end
```

### Registrations Controller

```ruby
class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      @user.send_confirmation_email
      redirect_to login_path, notice: 'Account created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :first_name, :last_name, :bio)
  end
end
```

## REST API Endpoints

### Posts API

```http
# List posts
GET /api/v1/posts
GET /api/v1/posts?page=1&per_page=12
GET /api/v1/posts?search=rails

# Get post
GET /api/v1/posts/:id

# Create post
POST /api/v1/posts
Content-Type: application/json

{
  "post": {
    "title": "New Post",
    "content": "Post content",
    "status": "published",
    "tag_list": ["ruby", "rails"]
  }
}

# Update post
PUT /api/v1/posts/:id
Content-Type: application/json

{
  "post": {
    "title": "Updated Post",
    "content": "Updated content"
  }
}

# Delete post
DELETE /api/v1/posts/:id
```

### Users API

```http
# List users
GET /api/v1/users
GET /api/v1/users?page=1&per_page=20

# Get user
GET /api/v1/users/:id

# Response
{
  "id": 1,
  "username": "john_doe",
  "email": "john@example.com",
  "first_name": "John",
  "last_name": "Doe",
  "bio": "User bio",
  "avatar_url": "https://example.com/avatar.jpg",
  "roles": ["user"],
  "created_at": "2024-01-01T00:00:00Z"
}
```

### Health Check API

```http
# Health check
GET /api/v1/health

# Response
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
    }
  }
}
```

## TypeScript Client API

### Installation

```bash
npm install graphql-ui-layout-client
```

### Basic Usage

```typescript
import { useUiLayout, useApiClient } from 'graphql-ui-layout-client';

function App() {
  const { navigation, sidebar, theme } = useUiLayout();
  const { search, paginate } = useApiClient();

  return (
    <div style={{ fontFamily: theme.fontFamily }}>
      <Navigation items={navigation.items} />
      <Sidebar widgets={sidebar.widgets} />
    </div>
  );
}
```

### Search Hook

```typescript
import { useSearch } from 'graphql-ui-layout-client';

function SearchComponent() {
  const { search, results, loading, error } = useSearch();

  const handleSearch = async (query: string) => {
    await search('posts', query, {
      limit: 20,
      include: ['user', 'tags']
    });
  };

  return (
    <div>
      <input onChange={(e) => handleSearch(e.target.value)} />
      {loading && <div>Loading...</div>}
      {error && <div>Error: {error.message}</div>}
      {results.map(post => (
        <div key={post.id}>{post.title}</div>
      ))}
    </div>
  );
}
```

### Pagination Hook

```typescript
import { usePagination } from 'graphql-ui-layout-client';

function PaginatedList() {
  const { paginate, data, pagination, loading } = usePagination();

  const loadPage = async (page: number) => {
    await paginate('posts', page, 12);
  };

  return (
    <div>
      {data.map(post => (
        <div key={post.id}>{post.title}</div>
      ))}
      <div>
        <button onClick={() => loadPage(pagination.currentPage - 1)}>
          Previous
        </button>
        <span>Page {pagination.currentPage} of {pagination.totalPages}</span>
        <button onClick={() => loadPage(pagination.currentPage + 1)}>
          Next
        </button>
      </div>
    </div>
  );
}
```

## Configuration API

### Basic Configuration

```ruby
Zeropoint.configure do |config|
  # Enable features
  config.features = [
    :graphql,
    :rails,
    :search,
    :pagination,
    :authorization,
    :cache,
    :analytics
  ]
  
  # Theme configuration
  config.theme = {
    primary_color: "#3b82f6",
    secondary_color: "#8b5cf6",
    font_family: "Inter, system-ui, sans-serif",
    border_radius: "12px"
  }
  
  # App configuration
  config.app_config = {
    app_name: "My App",
    default_locale: "en",
    pagination: { default_per_page: 12 }
  }
end
```

### Service Configuration

```ruby
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

config.analytics = {
  track_page_views: true,
  track_events: true
}
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

## Health Check API

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
  "version": "1.0.0",
  "services": {
    "search": {
      "status": "healthy",
      "adapter": "PgSearchAdapter",
      "available": true,
      "healthy": true
    },
    "pagination": {
      "status": "healthy",
      "adapter": "KaminariAdapter",
      "available": true,
      "healthy": true
    },
    "authorization": {
      "status": "healthy",
      "adapter": "PunditAdapter",
      "available": true,
      "healthy": true
    },
    "cache": {
      "status": "healthy",
      "adapter": "RedisAdapter",
      "available": true,
      "healthy": true
    },
    "analytics": {
      "status": "healthy",
      "adapter": "AhoyAdapter",
      "available": true,
      "healthy": true
    }
  },
  "adapters": {
    "search": ["PgSearchAdapter", "SearchkickAdapter"],
    "pagination": ["KaminariAdapter", "WillPaginateAdapter"],
    "cache": ["RedisAdapter", "DalliAdapter"],
    "analytics": ["AhoyAdapter", "MixpanelAdapter"]
  },
  "configuration": {
    "features": ["graphql", "rails", "search", "pagination"],
    "theme": {
      "primary_color": "#3b82f6",
      "font_family": "Inter, system-ui, sans-serif"
    }
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

### GraphQL Errors

```ruby
# GraphQL error handling
result = Zeropoint::Graphql::Schema.execute(query, variables: variables)

if result.errors.any?
  result.errors.each do |error|
    Rails.logger.error "GraphQL error: #{error.message}"
  end
end
```

### TypeScript Error Handling

```typescript
import { useApiClient } from 'graphql-ui-layout-client';

function ApiComponent() {
  const { search } = useApiClient();

  const handleSearch = async (query: string) => {
    try {
      const results = await search('posts', query);
      // Handle results
    } catch (error) {
      console.error('Search error:', error);
      // Handle error
    }
  };
}
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

### API Testing

```ruby
RSpec.describe "API endpoints" do
  it "returns posts" do
    get "/api/v1/posts"
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to include("posts")
  end
  
  it "returns health check" do
    get "/api/v1/health"
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["status"]).to eq("healthy")
  end
end
```

### GraphQL Testing

```ruby
RSpec.describe "GraphQL queries" do
  it "returns UI layout" do
    query = <<~GRAPHQL
      query {
        uiLayout {
          navigation {
            items {
              label
              url
            }
          }
        }
      }
    GRAPHQL
    
    result = Zeropoint::Graphql::Schema.execute(query)
    expect(result.errors).to be_empty
    expect(result.data["uiLayout"]["navigation"]).to be_present
  end
end
``` 