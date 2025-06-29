# frozen_string_literal: true

class AuthorizationService
  def initialize(user = nil)
    @user = user
    @policies = {}
    @roles = {}
    @permissions = {}
  end

  # Policy-based authorization
  def can?(action, resource, context = {})
    return true if admin_user?
    return false unless @user

    # Check custom policies first
    policy = find_policy(action, resource)
    return policy.call(@user, resource, context) if policy.respond_to?(:call)

    # Check role-based permissions
    return check_role_permission(action, resource) if has_role_permission?(action, resource)

    # Check default permissions
    check_default_permission(action, resource, context)
  end

  def cannot?(action, resource, context = {})
    !can?(action, resource, context)
  end

  # Policy management
  def add_policy(action, resource_class, &block)
    @policies["#{action}:#{resource_class}"] = block
  end

  def add_policies(policies = {})
    policies.each do |(action, resource_class), block|
      add_policy(action, resource_class, &block)
    end
  end

  def find_policy(action, resource)
    resource_class = (resource.is_a?(Class)) ? resource : resource.class
    @policies["#{action}:#{resource_class}"]
  end

  # Role-based authorization
  def has_role?(role)
    return false unless @user
    return true if admin_user?

    @user.has_role?(role) if @user.respond_to?(:has_role?)
  end

  def has_any_role?(*roles)
    roles.any? { |role| has_role?(role) }
  end

  def has_all_roles?(*roles)
    roles.all? { |role| has_role?(role) }
  end

  def add_role_permission(role, action, resource_class)
    @roles[role] ||= {}
    @roles[role]["#{action}:#{resource_class}"] = true
  end

  def has_role_permission?(action, resource)
    return false unless @user

    resource_class = (resource.is_a?(Class)) ? resource : resource.class
    user_roles = @user.roles.pluck(:name) if @user.respond_to?(:roles)
    return false unless user_roles

    user_roles.any? do |role|
      @roles[role]&.key?("#{action}:#{resource_class}")
    end
  end

  def check_role_permission(action, resource)
    resource_class = (resource.is_a?(Class)) ? resource : resource.class
    user_roles = @user.roles.pluck(:name) if @user.respond_to?(:roles)
    return false unless user_roles

    user_roles.any? do |role|
      @roles[role]&.key?("#{action}:#{resource_class}")
    end
  end

  # Permission-based authorization
  def add_permission(action, resource_class, conditions = {})
    @permissions["#{action}:#{resource_class}"] = conditions
  end

  def check_default_permission(action, resource, context = {})
    resource_class = (resource.is_a?(Class)) ? resource : resource.class
    permission = @permissions["#{action}:#{resource_class}"]
    return false unless permission

    evaluate_permission_conditions(permission, resource, context)
  end

  def evaluate_permission_conditions(conditions, resource, context)
    conditions.all? do |condition, value|
      case condition
      when :owner_only
        resource.respond_to?(:user_id) && resource.user_id == @user.id
      when :confirmed_user
        @user.respond_to?(:confirmed?) && @user.confirmed?
      when :active_user
        @user.respond_to?(:active?) && @user.active?
      when :custom
        value.call(@user, resource, context) if value.respond_to?(:call)
      else
        true
      end
    end
  end

  # Resource ownership
  def owns?(resource, ownership_field = :user_id)
    return false unless resource && @user

    resource.respond_to?(ownership_field) && resource.send(ownership_field) == @user.id
  end

  def owns_any?(resources, ownership_field = :user_id)
    resources.any? { |resource| owns?(resource, ownership_field) }
  end

  # Scope-based authorization
  def authorized_scope(resource_class, _action = :index)
    return resource_class.all if admin_user?

    if resource_class.respond_to?(:accessible_by)
      resource_class.accessible_by(@user)
    elsif resource_class.column_names.include?('user_id')
      resource_class.where(user_id: @user.id)
    else
      resource_class.none
    end
  end

  def filter_by_permissions(resources, action = :index)
    return resources if admin_user?

    resources.select { |resource| can?(action, resource) }
  end

  # CRUD-specific authorization
  def can_create?(resource_class)
    can?(:create, resource_class)
  end

  def can_read?(resource)
    can?(:read, resource)
  end

  def can_update?(resource)
    can?(:update, resource)
  end

  def can_delete?(resource)
    can?(:delete, resource)
  end

  def can_list?(resource_class)
    can?(:index, resource_class)
  end

  # Bulk authorization
  def can_perform_bulk_action?(action, resources)
    return true if admin_user?
    return false unless @user

    resources.all? { |resource| can?(action, resource) }
  end

  def can_perform_any_bulk_action?(action, resources)
    return true if admin_user?
    return false unless @user

    resources.any? { |resource| can?(action, resource) }
  end

  # Authorization with context
  def can_with_context?(action, resource, context = {})
    return true if admin_user?
    return false unless @user

    # Check if user can perform action in this context
    base_permission = can?(action, resource)
    return false unless base_permission

    # Apply context-specific rules
    apply_context_rules(action, resource, context)
  end

  def apply_context_rules(action, resource, context)
    # Time-based restrictions
    return false if context[:time_restricted] && !within_allowed_hours?

    # Location-based restrictions
    return false if context[:location_restricted] && !within_allowed_location?(context[:location])

    # Rate limiting
    return false if context[:rate_limited] && !within_rate_limit?(action, resource)

    true
  end

  # Utility methods
  def admin_user?
    @user&.admin?
  end

  def guest_user?
    @user.nil?
  end

  def authenticated_user?
    @user.present?
  end

  def within_allowed_hours?
    current_hour = Time.current.hour
    current_hour.between?(6, 22) # Example: 6 AM to 10 PM
  end

  def within_allowed_location?(_location)
    # Implement location-based authorization
    true
  end

  def within_rate_limit?(_action, _resource)
    # Implement rate limiting
    true
  end

  # Authorization caching
  def cache_authorization_result(action, resource, result, ttl = 300)
    cache_key = "auth:#{@user&.id}:#{action}:#{resource.class}:#{resource.id}"
    cache_service.write(cache_key, result, expires_in: ttl)
  end

  def cached_authorization_result(action, resource)
    cache_key = "auth:#{@user&.id}:#{action}:#{resource.class}:#{resource.id}"
    cache_service.read(cache_key)
  end

  # Authorization reporting
  def authorization_report(resource_class, actions = %i[create read update delete])
    report = {}

    actions.each do |action|
      report[action] = {
        can_perform: can?(action, resource_class),
        requires_roles: required_roles_for(action, resource_class),
        requires_permissions: required_permissions_for(action, resource_class)
      }
    end

    report
  end

  def required_roles_for(action, resource_class)
    @roles.select { |_role, permissions| permissions.key?("#{action}:#{resource_class}") }.keys
  end

  def required_permissions_for(action, resource_class)
    @permissions["#{action}:#{resource_class}"]
  end

  private

  def cache_service
    @cache_service ||= Zeropoint::Core::CacheService.new(Zeropoint.configuration)
  end
end
