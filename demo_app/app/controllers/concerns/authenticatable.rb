# frozen_string_literal: true

module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  class_methods do
    def skip_authentication(*actions)
      skip_before_action :authenticate_user!, only: actions
    end

    def require_authentication(*actions)
      before_action :authenticate_user!, only: actions
    end

    def optional_authentication(*actions)
      skip_before_action :authenticate_user!, only: actions
      before_action :set_optional_user, only: actions
    end
  end

  private

  def authenticate_user!
    return if current_user

    handle_authentication_failure
  end

  def set_optional_user
    # For optional authentication, current_user can be nil
    # This allows public access while still providing user context when available
  end

  def handle_authentication_failure
    respond_to do |format|
      format.html { redirect_to login_path, alert: authentication_failure_message }
      format.json { render json: { error: authentication_failure_message }, status: :unauthorized }
      format.js { render js: "window.location.href = '#{login_path}'" }
    end
  end

  def authentication_failure_message
    I18n.t('demo.authentication.required')
  end

  def current_user
    @current_user ||= find_current_user
  end

  def find_current_user
    # Override this method in your application controller or specific controllers
    # to implement different authentication strategies
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def signed_in_user?
    user_signed_in?
  end

  # Authentication strategies
  def authenticate_with_session!
    # Default session-based authentication
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_with_token!
    # Token-based authentication (e.g., API tokens)
    token = request.headers['Authorization']&.gsub('Bearer ', '')
    return nil unless token

    User.find_by(api_token: token) if defined?(User) && User.column_names.include?('api_token')
  end

  def authenticate_with_api_key!
    # API key authentication
    api_key = request.headers['X-API-Key']
    return nil unless api_key

    User.find_by(api_key: api_key) if defined?(User) && User.column_names.include?('api_key')
  end

  def authenticate_with_oauth!
    # OAuth-based authentication
    # This would integrate with your OAuth provider
    # Example: OmniAuth, Devise Token Auth, etc.
    nil # Implement based on your OAuth setup
  end

  # Guest user support
  def guest_user
    @guest_user ||= create_guest_user if allow_guest_access?
  end

  def allow_guest_access?
    false # Override in controllers that allow guest access
  end

  def create_guest_user
    # Create a temporary guest user for anonymous actions
    # This could be a temporary session-based user
    nil # Implement based on your guest user strategy
  end
end
