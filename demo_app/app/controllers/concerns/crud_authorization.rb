# frozen_string_literal: true

module CrudAuthorization
  extend ActiveSupport::Concern

  included do
    include Authenticatable
    include Authorizable

    before_action :set_crud_authorization_config
  end

  class_methods do
    def crud_authorization_config
      @crud_authorization_config ||= default_crud_config
    end

    def configure_crud_authorization(options = {})
      @crud_authorization_config = default_crud_config.merge(options)
    end

    def crud_actions(*actions)
      @crud_authorization_config[:actions] = actions
    end

    def crud_roles(*roles)
      @crud_authorization_config[:roles] = roles
    end

    def crud_policies(policies = {})
      @crud_authorization_config[:policies] = policies
    end

    def crud_ownership(field)
      @crud_authorization_config[:ownership] = field
    end

    def crud_public_actions(*actions)
      @crud_authorization_config[:public_actions] = actions
    end

    def crud_admin_only_actions(*actions)
      @crud_authorization_config[:admin_only_actions] = actions
    end

    def crud_owner_only_actions(*actions)
      @crud_authorization_config[:owner_only_actions] = actions
    end

    private

    def default_crud_config
      {
        actions: %i[index show new create edit update destroy],
        roles: {},
        policies: {},
        ownership: :user_id,
        public_actions: [],
        admin_only_actions: [],
        owner_only_actions: [],
        authentication_strategy: :session,
        authorization_strategy: :standard
      }
    end
  end

  private

  def set_crud_authorization_config
    @crud_config = self.class.crud_authorization_config
  end

  def crud_config
    @crud_config
  end

  # Override authentication for CRUD-specific needs
  def authenticate_user!
    action = action_name.to_sym

    # Skip authentication for public actions
    return if crud_config[:public_actions].include?(action)

    # Use different authentication strategies
    case crud_config[:authentication_strategy]
    when :token
      authenticate_with_token!
    when :api_key
      authenticate_with_api_key!
    when :oauth
      authenticate_with_oauth!
    else
      super
    end
  end

  # Override authorization for CRUD-specific needs
  def action_authorized?
    action = action_name.to_sym

    # Admin can do everything
    return true if current_user&.admin?

    # Check admin-only actions
    return false if crud_config[:admin_only_actions].include?(action)

    # Check owner-only actions
    if crud_config[:owner_only_actions].include?(action)
      resource = find_resource_for_authorization
      return owns_resource?(resource)
    end

    # Check role-based authorization
    return has_any_role?(*Array(crud_config[:roles][action])) if crud_config[:roles][action]

    # Check custom policies
    if crud_config[:policies][action]
      policy = crud_config[:policies][action]
      resource = find_resource_for_authorization
      return policy.call(current_user, resource) if policy.respond_to?(:call)
    end

    # Fall back to standard authorization
    super
  end

  # CRUD-specific authorization methods
  def can_list_resources?
    return true if current_user&.admin?

    if crud_config[:roles][:index]
      has_any_role?(*Array(crud_config[:roles][:index]))
    else
      can_list?(resource_class)
    end
  end

  def can_view_resource?(resource)
    return true if current_user&.admin?

    if crud_config[:roles][:show]
      has_any_role?(*Array(crud_config[:roles][:show]))
    else
      can_view?(resource)
    end
  end

  def can_create_resource?
    return true if current_user&.admin?

    if crud_config[:roles][:create]
      has_any_role?(*Array(crud_config[:roles][:create]))
    else
      can_create?(resource_class)
    end
  end

  def can_update_resource?(resource)
    return true if current_user&.admin?

    if crud_config[:roles][:update]
      has_any_role?(*Array(crud_config[:roles][:update]))
    elsif crud_config[:owner_only_actions].include?(:update)
      owns_resource?(resource)
    else
      can_update?(resource)
    end
  end

  def can_delete_resource?(resource)
    return true if current_user&.admin?

    if crud_config[:roles][:destroy]
      has_any_role?(*Array(crud_config[:roles][:destroy]))
    elsif crud_config[:owner_only_actions].include?(:destroy)
      owns_resource?(resource)
    else
      can_delete?(resource)
    end
  end

  # Resource scoping for CRUD operations
  def authorized_resources
    return resource_class.all if current_user&.admin?

    if crud_config[:ownership] && resource_class.column_names.include?(crud_config[:ownership].to_s)
      resource_class.where(crud_config[:ownership] => current_user.id)
    elsif resource_class.respond_to?(:accessible_by)
      resource_class.accessible_by(current_user)
    else
      resource_class.none
    end
  end

  # CRUD action filtering
  def available_crud_actions
    actions = crud_config[:actions].dup

    # Remove actions based on permissions
    actions.delete(:index) unless can_list_resources?
    actions.delete(:new) unless can_create_resource?
    actions.delete(:create) unless can_create_resource?

    # For existing resources, check update/delete permissions
    if instance_variable_defined?("@#{controller_name.singularize}")
      resource = instance_variable_get("@#{controller_name.singularize}")
      actions.delete(:edit) unless can_update_resource?(resource)
      actions.delete(:update) unless can_update_resource?(resource)
      actions.delete(:destroy) unless can_delete_resource?(resource)
    end

    actions
  end

  # Authorization helpers for views
  def can_perform_crud_action?(action, resource = nil)
    case action.to_sym
    when :index
      can_list_resources?
    when :show
      can_view_resource?(resource)
    when :new, :create
      can_create_resource?
    when :edit, :update
      can_update_resource?(resource)
    when :destroy
      can_delete_resource?(resource)
    else
      false
    end
  end

  def cannot_perform_crud_action?(action, resource = nil)
    !can_perform_crud_action?(action, resource)
  end

  # Expose CRUD authorization methods to views
  helper_method :can_perform_crud_action?, :cannot_perform_crud_action?, :available_crud_actions, :authorized_resources
end
