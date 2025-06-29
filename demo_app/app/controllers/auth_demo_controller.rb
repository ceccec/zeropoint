# frozen_string_literal: true

class AuthDemoController < ApplicationController
  include CrudAuthorization

  # Demo 1: Public access with optional authentication
  configure_crud_authorization(
    actions: %i[public_demo],
    public_actions: [ :public_demo ]
  )

  # Demo 2: User-only access
  configure_crud_authorization(
    actions: %i[user_only_demo],
    roles: { user_only_demo: [ :user, :admin ] }
  )

  # Demo 3: Role-based access
  configure_crud_authorization(
    actions: %i[role_based_demo],
    roles: {
      role_based_demo: [ :admin, :moderator ]
    }
  )

  # Demo 4: Owner-only access
  configure_crud_authorization(
    actions: %i[owner_only_demo],
    owner_only_actions: [ :owner_only_demo ],
    ownership: :user_id
  )

  # Demo 5: Custom policy
  configure_crud_authorization(
    actions: %i[policy_demo],
    policies: {
      policy_demo: ->(user, resource) {
        user.confirmed? && user.posts.count < 5
      }
    }
  )

  def public_demo
    render json: {
      message: "This is a public demo - no authentication required",
      authenticated: user_signed_in?,
      current_user: current_user&.username,
      can_create: can?(:create, Post),
      can_update: Post.first ? can?(:update, Post.first) : nil
    }
  end

  def user_only_demo
    render json: {
      message: "This is a user-only demo",
      current_user: current_user.username,
      user_roles: current_user.roles.pluck(:name),
      can_perform_actions: {
        create_post: can?(:create, Post),
        update_post: Post.first ? can?(:update, Post.first) : nil,
        delete_post: Post.first ? can?(:delete, Post.first) : nil
      }
    }
  end

  def role_based_demo
    render json: {
      message: "This is a role-based demo (admin/moderator only)",
      current_user: current_user.username,
      user_roles: current_user.roles.pluck(:name),
      is_admin: current_user.admin?,
      is_moderator: current_user.moderator?,
      authorization_report: authorization_service.authorization_report(Post)
    }
  end

  def owner_only_demo
    post = Post.find(params[:post_id])
    render json: {
      message: "This is an owner-only demo",
      current_user: current_user.username,
      post_owner: post.user.username,
      owns_post: owns?(post),
      can_update: can?(:update, post),
      can_delete: can?(:delete, post)
    }
  end

  def policy_demo
    render json: {
      message: "This is a custom policy demo",
      current_user: current_user.username,
      user_confirmed: current_user.confirmed?,
      posts_count: current_user.posts.count,
      can_create_more: current_user.posts.count < 5,
      policy_result: authorization_service.can?(:create, Post)
    }
  end

  def bulk_authorization_demo
    posts = Post.limit(3)
    render json: {
      message: "Bulk authorization demo",
      current_user: current_user.username,
      posts_count: posts.count,
      can_update_all: authorization_service.can_perform_bulk_action?(:update, posts),
      can_delete_any: authorization_service.can_perform_any_bulk_action?(:delete, posts),
      individual_permissions: posts.map { |post|
        {
          id: post.id,
          can_update: can?(:update, post),
          can_delete: can?(:delete, post),
          owns: owns?(post)
        }
      }
    }
  end

  def context_authorization_demo
    post = Post.first
    context = {
      time_restricted: true,
      location_restricted: false,
      rate_limited: true
    }

    render json: {
      message: "Context-based authorization demo",
      current_user: current_user.username,
      current_time: Time.current.hour,
      within_allowed_hours: authorization_service.within_allowed_hours?,
      can_update_with_context: authorization_service.can_with_context?(:update, post, context),
      context: context
    }
  end

  def authentication_strategies_demo
    render json: {
      message: "Authentication strategies demo",
      session_user: authenticate_with_session!&.username,
      token_user: authenticate_with_token!&.username,
      api_key_user: authenticate_with_api_key!&.username,
      current_user: current_user&.username,
      request_headers: {
        authorization: request.headers['Authorization'],
        api_key: request.headers['X-API-Key']
      }
    }
  end

  def authorization_service_demo
    post = Post.first
    render json: {
      message: "Authorization service demo",
      current_user: current_user&.username,
      service_methods: {
        admin_user: authorization_service.admin_user?,
        guest_user: authorization_service.guest_user?,
        authenticated_user: authorization_service.authenticated_user?,
        can_read: authorization_service.can_read?(post),
        can_update: authorization_service.can_update?(post),
        can_delete: authorization_service.can_delete?(post),
        owns: authorization_service.owns?(post)
      },
      role_checks: {
        has_admin_role: authorization_service.has_role?(:admin),
        has_moderator_role: authorization_service.has_role?(:moderator),
        has_user_role: authorization_service.has_role?(:user),
        has_any_role: authorization_service.has_any_role?(:admin, :moderator),
        has_all_roles: authorization_service.has_all_roles?(:user, :confirmed)
      }
    }
  end

  def crud_actions_demo
    render json: {
      message: "Available CRUD actions demo",
      current_user: current_user&.username,
      available_actions: available_crud_actions,
      can_perform_actions: {
        index: can_perform_crud_action?(:index),
        show: can_perform_crud_action?(:show),
        new: can_perform_crud_action?(:new),
        create: can_perform_crud_action?(:create),
        edit: can_perform_crud_action?(:edit),
        update: can_perform_crud_action?(:update),
        destroy: can_perform_crud_action?(:destroy)
      }
    }
  end

  private

  def resource_class
    Post
  end

  def resource_params
    params.require(:post).permit(:title, :content, :status)
  end
end
