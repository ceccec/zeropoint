# frozen_string_literal: true

# Authorization Configuration
# This file configures the default authorization policies and permissions

Rails.application.config.after_initialize do
  # Initialize the global authorization service
  authorization_service = AuthorizationService.new

  # Configure default policies for Post model
  authorization_service.add_policies({
                                       [ :create, Post ] => ->(user, _resource) { user.confirmed? },
                                       [ :read, Post ] => lambda { |user, resource|
                                         resource.published? || user&.admin? || resource.user_id == user&.id
                                       },
                                       [ :update, Post ] => lambda { |user, resource|
                                         user.admin? || resource.user_id == user.id
                                       },
                                       [ :delete, Post ] => lambda { |user, resource|
                                         user.admin? || resource.user_id == user.id
                                       }
                                     })

  # Configure default policies for User model
  authorization_service.add_policies({
                                       [ :read, User ] => ->(_user, _resource) { true }, # Public profiles
                                       [ :update, User ] => ->(user, resource) { user.admin? || resource.id == user.id },
                                       [ :delete, User ] => ->(user, _resource) { user.admin? }
                                     })

  # Configure default policies for Comment model
  authorization_service.add_policies({
                                       [ :create, Comment ] => ->(user, _resource) { user.confirmed? },
                                       [ :read, Comment ] => ->(_user, _resource) { true }, # Public comments
                                       [ :update, Comment ] => lambda { |user, resource|
                                         user.admin? || resource.user_id == user.id
                                       },
                                       [ :delete, Comment ] => lambda { |user, resource|
                                         user.admin? || resource.user_id == user.id
                                       }
                                     })

  # Configure role-based permissions
  authorization_service.add_role_permission(:admin, :manage, Post)
  authorization_service.add_role_permission(:admin, :manage, User)
  authorization_service.add_role_permission(:admin, :manage, Comment)

  authorization_service.add_role_permission(:moderator, :read, Post)
  authorization_service.add_role_permission(:moderator, :update, Post)
  authorization_service.add_role_permission(:moderator, :delete, Comment)

  authorization_service.add_role_permission(:user, :create, Post)
  authorization_service.add_role_permission(:user, :read, Post)
  authorization_service.add_role_permission(:user, :update, Post) # Own posts only
  authorization_service.add_role_permission(:user, :create, Comment)
  authorization_service.add_role_permission(:user, :read, Comment)
  authorization_service.add_role_permission(:user, :update, Comment) # Own comments only

  # Configure default permissions
  authorization_service.add_permission(:create, Post, { confirmed_user: true })
  authorization_service.add_permission(:read, Post, {}) # Public
  authorization_service.add_permission(:update, Post, { owner_only: true })
  authorization_service.add_permission(:delete, Post, { owner_only: true })

  authorization_service.add_permission(:create, Comment, { confirmed_user: true })
  authorization_service.add_permission(:read, Comment, {}) # Public
  authorization_service.add_permission(:update, Comment, { owner_only: true })
  authorization_service.add_permission(:delete, Comment, { owner_only: true })

  # Store the configured service for global access
  Rails.application.config.authorization_service = authorization_service
end

# Authorization configuration for different environments
case Rails.env
when 'development'
  # Development-specific authorization rules
  Rails.application.config.authorization_debug = true

when 'test'
  # Test-specific authorization rules
  Rails.application.config.authorization_debug = false

when 'production'
  # Production-specific authorization rules
  Rails.application.config.authorization_debug = false

  # Additional security measures for production
  Rails.application.config.after_initialize do
    authorization_service = Rails.application.config.authorization_service

    # Add rate limiting policies
    authorization_service.add_policies({
                                         [ :create, Post ] => lambda { |user, _resource, context|
                                           return false unless user.confirmed?
                                           return true unless context[:rate_limited]

                                           # Check rate limiting (example: max 5 posts per hour)
                                           user.posts.where('created_at > ?', 1.hour.ago).count < 5
                                         }
                                       })
  end
end
