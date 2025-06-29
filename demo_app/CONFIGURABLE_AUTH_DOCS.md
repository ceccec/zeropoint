# Configurable Authentication and Authorization System

## Overview

The GraphQL UI Layout demo application includes a comprehensive, configurable authentication and authorization system that provides flexible access control for CRUD operations. This system is built on Rails concerns and service objects, making it easy to customize and extend.

## Architecture

### Core Components

1. **Authenticatable Concern** - Handles user authentication with multiple strategies
2. **Authorizable Concern** - Provides flexible permission checking
3. **CrudAuthorization Concern** - Combines authentication and authorization for CRUD operations
4. **AuthorizationService** - Centralized authorization logic and policy management
5. **Configuration Initializer** - Global authorization policies and permissions

## Authentication Strategies

### 1. Session-Based Authentication (Default)
```ruby
class PostsController < ApplicationController
  include Authenticatable
  
  # Uses session-based authentication by default
  before_action :authenticate_user!
end
```

### 2. Token-Based Authentication
```ruby
class Api::V1::PostsController < ApplicationController
  include Authenticatable
  
  # Configure for token authentication
  configure_crud_authorization(
    authentication_strategy: :token
  )
  
  def find_current_user
    authenticate_with_token!
  end
end
```

### 3. API Key Authentication
```ruby
class Api::V1::PostsController < ApplicationController
  include Authenticatable
  
  # Configure for API key authentication
  configure_crud_authorization(
    authentication_strategy: :api_key
  )
  
  def find_current_user
    authenticate_with_api_key!
  end
end
```

### 4. OAuth Authentication
```ruby
class OAuthController < ApplicationController
  include Authenticatable
  
  def find_current_user
    authenticate_with_oauth!
  end
end
```

### 5. Mixed Authentication Strategies
```ruby
class ApplicationController < ActionController::Base
  include Authenticatable
  
  def find_current_user
    if api_request?
      authenticate_with_token! || authenticate_with_api_key!
    elsif oauth_request?
      authenticate_with_oauth!
    else
      authenticate_with_session!
    end
  end
end
```

## Authorization Levels

### 1. Public Actions (No Authentication Required)
```ruby
class PostsController < ApplicationController
  include CrudAuthorization
  
  configure_crud_authorization(
    public_actions: [:index, :show]
  )
  
  # These actions are accessible without authentication
  def index; end
  def show; end
end
```

### 2. Authenticated Actions (User Required)
```ruby
class PostsController < ApplicationController
  include CrudAuthorization
  
  configure_crud_authorization(
    actions: [:create, :update, :destroy],
    roles: {
      create: [:user, :admin],
      update: [:user, :admin],
      destroy: [:admin]
    }
  )
end
```

### 3. Role-Based Authorization
```ruby
class Admin::PostsController < ApplicationController
  include CrudAuthorization
  
  configure_crud_authorization(
    roles: {
      index: [:admin, :moderator],
      show: [:admin, :moderator],
      new: [:admin],
      create: [:admin],
      edit: [:admin, :moderator],
      update: [:admin, :moderator],
      destroy: [:admin]
    }
  )
end
```

### 4. Owner-Only Actions
```ruby
class PostsController < ApplicationController
  include CrudAuthorization
  
  configure_crud_authorization(
    owner_only_actions: [:update, :destroy],
    ownership: :user_id
  )
end
```

### 5. Admin-Only Actions
```ruby
class Admin::UsersController < ApplicationController
  include CrudAuthorization
  
  configure_crud_authorization(
    admin_only_actions: [:index, :show, :new, :create, :edit, :update, :destroy]
  )
end
```

## Policy-Based Authorization

### 1. Custom Policies
```ruby
class PostsController < ApplicationController
  include CrudAuthorization
  
  configure_crud_authorization(
    policies: {
      create: ->(user, resource) { user.confirmed? && user.posts.count < 10 },
      update: ->(user, resource) { user.admin? || (resource.user_id == user.id && resource.published?) },
      destroy: ->(user, resource) { user.admin? || (resource.user_id == user.id && resource.draft?) }
    }
  )
end
```

### 2. Complex Policies
```ruby
class PostsController < ApplicationController
  include CrudAuthorization
  
  configure_crud_authorization(
    policies: {
      update: ->(user, resource, context) {
        return false unless user.confirmed?
        return true if user.admin?
        return false unless resource.user_id == user.id
        
        # Check time restrictions
        if context[:time_restricted]
          return false unless Time.current.hour >= 6 && Time.current.hour <= 22
        end
        
        # Check rate limiting
        if context[:rate_limited]
          return false unless user.posts.where('updated_at > ?', 1.hour.ago).count < 5
        end
        
        true
      }
    }
  )
end
```

## Authorization Service

### 1. Basic Usage
```ruby
class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    
    if authorization_service.can?(:read, @post)
      render json: @post
    else
      render_unauthorized
    end
  end
end
```

### 2. Role Checking
```ruby
# Check if user has specific role
if authorization_service.has_role?(:admin)
  # Admin-only code
end

# Check if user has any of multiple roles
if authorization_service.has_any_role?(:admin, :moderator)
  # Admin or moderator code
end

# Check if user has all roles
if authorization_service.has_all_roles?(:user, :verified)
  # User with verified status code
end
```

### 3. Resource Ownership
```ruby
# Check if user owns the resource
if authorization_service.owns?(@post)
  # Owner-only code
end

# Check ownership with custom field
if authorization_service.owns?(@post, :author_id)
  # Custom ownership field
end
```

### 4. Bulk Authorization
```ruby
# Check if user can perform action on all resources
posts = Post.where(id: params[:post_ids])
if authorization_service.can_perform_bulk_action?(:update, posts)
  posts.update_all(status: 'published')
end

# Check if user can perform action on any resource
if authorization_service.can_perform_any_bulk_action?(:delete, posts)
  # At least one post can be deleted
end
```

### 5. Context-Based Authorization
```ruby
context = {
  time_restricted: true,
  location_restricted: true,
  location: request.remote_ip,
  rate_limited: true
}

if authorization_service.can_with_context?(:update, @post, context)
  @post.update(post_params)
else
  render_error("Action not allowed in current context")
end
```

## Configuration Examples

### 1. Simple CRUD Controller
```ruby
class PostsController < ApplicationController
  include CrudOperations
  include CrudAuthorization
  
  configure_crud_authorization(
    actions: %i[index show new create edit update destroy],
    public_actions: [:index, :show],
    owner_only_actions: [:edit, :update, :destroy],
    ownership: :user_id
  )
  
  private
  
  def resource_class
    Post
  end
  
  def resource_params
    params.require(:post).permit(:title, :content, :status)
  end
end
```

### 2. Admin Controller
```ruby
module Admin
  class UsersController < ApplicationController
    include CrudOperations
    include CrudAuthorization
    
    configure_crud_authorization(
      actions: %i[index show new create edit update destroy],
      admin_only_actions: [:index, :show, :new, :create, :edit, :update, :destroy],
      ownership: :id
    )
    
    private
    
    def resource_class
      User
    end
    
    def resource_params
      params.require(:user).permit(:email, :username, :role_ids)
    end
  end
end
```

### 3. API Controller
```ruby
module Api
  module V1
    class PostsController < ApplicationController
      include CrudAuthorization
      
      configure_crud_authorization(
        actions: %i[index show create update destroy],
        public_actions: [:index, :show],
        owner_only_actions: [:update, :destroy],
        authentication_strategy: :token
      )
      
      def index
        posts = Post.published
        render json: posts
      end
      
      def create
        post = current_user.posts.build(post_params)
        if post.save
          render json: post, status: :created
        else
          render json: { errors: post.errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
```

### 4. Mixed Access Controller
```ruby
class DocumentsController < ApplicationController
  include CrudAuthorization
  
  configure_crud_authorization(
    actions: %i[index show create update destroy],
    public_actions: [:index, :show],
    roles: {
      create: [:user, :admin],
      update: [:user, :admin, :moderator],
      destroy: [:admin]
    },
    policies: {
      update: ->(user, resource) {
        user.confirmed? && (user.admin? || user.moderator? || resource.user_id == user.id)
      }
    },
    ownership: :user_id
  )
end
```

## Global Configuration

### 1. Authorization Initializer
```ruby
# config/initializers/authorization.rb
Rails.application.config.after_initialize do
  authorization_service = AuthorizationService.new
  
  # Configure default policies
  authorization_service.add_policies({
    [:create, Post] => ->(user, resource) { user.confirmed? },
    [:read, Post] => ->(user, resource) { resource.published? || user&.admin? || resource.user_id == user&.id },
    [:update, Post] => ->(user, resource) { user.admin? || resource.user_id == user.id },
    [:delete, Post] => ->(user, resource) { user.admin? || resource.user_id == user.id }
  })
  
  # Configure role-based permissions
  authorization_service.add_role_permission(:admin, :manage, Post)
  authorization_service.add_role_permission(:moderator, :read, Post)
  authorization_service.add_role_permission(:user, :create, Post)
  
  Rails.application.config.authorization_service = authorization_service
end
```

### 2. Environment-Specific Configuration
```ruby
case Rails.env
when 'development'
  Rails.application.config.authorization_debug = true
  
when 'production'
  Rails.application.config.authorization_debug = false
  
  # Add production-specific policies
  authorization_service.add_policies({
    [:create, Post] => ->(user, resource, context) {
      return false unless user.confirmed?
      return true unless context[:rate_limited]
      
      # Rate limiting: max 5 posts per hour
      user.posts.where('created_at > ?', 1.hour.ago).count < 5
    }
  })
end
```

## Helper Methods

### 1. View Helpers
```erb
<!-- Check if user can perform action -->
<% if can?(:update, @post) %>
  <%= link_to 'Edit', edit_post_path(@post) %>
<% end %>

<% if cannot?(:delete, @post) %>
  <p>You cannot delete this post</p>
<% end %>

<!-- Check resource ownership -->
<% if owns?(@post) %>
  <p>This is your post</p>
<% end %>

<!-- Check roles -->
<% if has_role?(:admin) %>
  <p>Admin panel</p>
<% end %>
```

### 2. Controller Helpers
```ruby
class PostsController < ApplicationController
  def index
    @posts = if can?(:manage, Post)
               Post.all
             else
               Post.published
             end
  end
  
  def show
    @post = Post.find(params[:id])
    unless can?(:read, @post)
      redirect_to posts_path, alert: 'Access denied'
    end
  end
end
```

## Testing

### 1. Controller Tests
```ruby
RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:post) { create(:post, user: user) }
  
  describe 'GET #index' do
    context 'when user is not authenticated' do
      it 'allows access to public posts' do
        get :index
        expect(response).to be_successful
      end
    end
    
    context 'when user is authenticated' do
      before { sign_in user }
      
      it 'allows access to all posts' do
        get :index
        expect(response).to be_successful
      end
    end
  end
  
  describe 'PUT #update' do
    context 'when user owns the post' do
      before { sign_in user }
      
      it 'allows update' do
        put :update, params: { id: post.id, post: { title: 'New Title' } }
        expect(response).to redirect_to(post_path(post))
      end
    end
    
    context 'when user does not own the post' do
      let(:other_user) { create(:user) }
      before { sign_in other_user }
      
      it 'denies access' do
        put :update, params: { id: post.id, post: { title: 'New Title' } }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
```

### 2. Service Tests
```ruby
RSpec.describe AuthorizationService do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:post) { create(:post, user: user) }
  let(:service) { described_class.new(user) }
  
  describe '#can?' do
    it 'allows admin to perform any action' do
      admin_service = described_class.new(admin)
      expect(admin_service.can?(:delete, post)).to be true
    end
    
    it 'allows owner to update their post' do
      expect(service.can?(:update, post)).to be true
    end
    
    it 'prevents non-owner from updating post' do
      other_user = create(:user)
      other_service = described_class.new(other_user)
      expect(other_service.can?(:update, post)).to be false
    end
  end
end
```

## Best Practices

### 1. Security
- Always validate permissions on both client and server side
- Use HTTPS in production
- Implement rate limiting for sensitive actions
- Log authorization failures for security monitoring

### 2. Performance
- Cache authorization results when appropriate
- Use database-level authorization when possible
- Avoid N+1 queries in authorization checks

### 3. Maintainability
- Keep policies simple and focused
- Use descriptive policy names
- Document complex authorization logic
- Test authorization thoroughly

### 4. Flexibility
- Design for future permission changes
- Use configuration over code when possible
- Support multiple authentication strategies
- Allow for context-based authorization

## Conclusion

The configurable authentication and authorization system provides a robust, flexible foundation for access control in Rails applications. By using concerns, service objects, and configuration files, it maintains clean separation of concerns while providing powerful authorization capabilities.

The system supports:
- Multiple authentication strategies
- Role-based and policy-based authorization
- Resource ownership checking
- Bulk operations
- Context-aware authorization
- Comprehensive testing support

This makes it suitable for applications ranging from simple blogs to complex enterprise systems with sophisticated access control requirements. 