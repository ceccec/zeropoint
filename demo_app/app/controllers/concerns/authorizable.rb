# frozen_string_literal: true

module Authorizable
  extend ActiveSupport::Concern

  included do
    before_action :authorize_action!
  end

  class_methods do
    def skip_authorization(*actions)
      skip_before_action :authorize_action!, only: actions
    end

    def require_authorization(*actions)
      before_action :authorize_action!, only: actions
    end

    def authorize_resource(resource_class, options = {})
      @authorization_config = {
        resource_class: resource_class,
        actions: options[:actions] || %i[index show create update destroy],
        policies: options[:policies] || {},
        roles: options[:roles] || {},
        ownership: options[:ownership] || :user_id
      }
    end

    def authorization_config
      @authorization_config || {}
    end
  end

  private

  def authorize_action!
    return if skip_authorization?
    return if action_authorized?

    handle_authorization_failure
  end

  def skip_authorization?
    # Skip authorization for certain conditions
    false
  end

  def action_authorized?
    action = action_name.to_sym
    resource = find_resource_for_authorization

    case action
    when :index
      can_list?(resource)
    when :show
      can_view?(resource)
    when :new, :create
      can_create?(resource)
    when :edit, :update
      can_update?(resource)
    when :destroy
      can_delete?(resource)
    else
      can_perform_action?(action, resource)
    end
  end

  def find_resource_for_authorization
    # Try to find the resource for the current action
    if respond_to?(:resource_class)
      resource_class
    elsif instance_variable_defined?("@#{controller_name.singularize}")
      instance_variable_get("@#{controller_name.singularize}")
    else
      controller_name.classify.constantize
    end
  rescue NameError
    nil
  end

  # Basic authorization methods
  def can_list?(resource_class)
    return true unless resource_class.respond_to?(:accessible_by)
    return true if current_user&.admin?

    resource_class.accessible_by(current_user)
    true
  rescue StandardError
    false
  end

  def can_view?(resource)
    return true unless resource
    return true if current_user&.admin?

    (resource.respond_to?(:can_view?)) ? resource.can_view?(current_user) : true
  end

  def can_create?(resource_class)
    return true if current_user&.admin?
    return false unless current_user

    # Check if user can create this type of resource
    if resource_class.respond_to?(:creatable_by)
      resource_class.creatable_by(current_user)
    elsif current_user.respond_to?(:confirmed?)
      current_user.confirmed?
    end
  end

  def can_update?(resource)
    return true if current_user&.admin?
    return false unless resource && current_user

    (resource.respond_to?(:can_edit?)) ? resource.can_edit?(current_user) : false
  end

  def can_delete?(resource)
    return true if current_user&.admin?
    return false unless resource && current_user

    (resource.respond_to?(:can_delete?)) ? resource.can_delete?(current_user) : false
  end

  def can_perform_action?(action, resource)
    # Custom action authorization
    return true if current_user&.admin?

    # Check custom policies
    policy = authorization_policy_for(action)
    return policy.call(current_user, resource) if policy.respond_to?(:call)

    # Default to false for unknown actions
    false
  end

  # Role-based authorization
  def has_role?(role)
    return false unless current_user
    return true if current_user.admin?

    current_user.has_role?(role) if current_user.respond_to?(:has_role?)
  end

  def has_any_role?(*roles)
    roles.any? { |role| has_role?(role) }
  end

  def has_all_roles?(*roles)
    roles.all? { |role| has_role?(role) }
  end

  # Resource ownership
  def owns_resource?(resource)
    return false unless resource && current_user

    ownership_field = authorization_config[:ownership] || :user_id
    resource.respond_to?(ownership_field) && resource.send(ownership_field) == current_user.id
  end

  # Custom policies
  def authorization_policy_for(action)
    config = self.class.authorization_config
    config[:policies]&.fetch(action.to_sym)
  end

  def set_authorization_policy(action, &block)
    @authorization_policies ||= {}
    @authorization_policies[action.to_sym] = block
  end

  # Authorization scopes
  def authorized_scope(resource_class, _action = :index)
    return resource_class.all if current_user&.admin?

    if resource_class.respond_to?(:accessible_by)
      resource_class.accessible_by(current_user)
    elsif resource_class.respond_to?(:where)
      ownership_field = authorization_config[:ownership] || :user_id
      resource_class.where(ownership_field => current_user.id)
    else
      resource_class.none
    end
  end

  def handle_authorization_failure
    respond_to do |format|
      format.html { redirect_to root_path, alert: authorization_failure_message }
      format.json { render json: { error: authorization_failure_message }, status: :forbidden }
      format.js { render js: "alert('#{authorization_failure_message}')" }
    end
  end

  def authorization_failure_message
    I18n.t('demo.authorization.forbidden')
  end

  # Authorization configuration
  def authorization_config
    self.class.authorization_config
  end

  # Helper methods for views
  def can?(action, resource = nil)
    case action.to_sym
    when :list
      can_list?(resource || controller_name.classify.constantize)
    when :view
      can_view?(resource)
    when :create
      can_create?(resource || controller_name.classify.constantize)
    when :update
      can_update?(resource)
    when :delete
      can_delete?(resource)
    else
      can_perform_action?(action, resource)
    end
  end

  def cannot?(action, resource = nil)
    !can?(action, resource)
  end

  # Expose authorization methods to views
  helper_method :can?, :cannot?, :has_role?, :has_any_role?, :has_all_roles?, :owns_resource?
end
