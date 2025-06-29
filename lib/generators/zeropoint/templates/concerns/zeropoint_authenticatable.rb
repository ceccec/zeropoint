# frozen_string_literal: true

# Zeropoint Authenticatable Concern
# Provides authentication integration with Rails 8's default authentication system

module ZeropointAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :set_consciousness_context
    before_action :set_vortex_context
  end

  private

  # Authenticate user using Rails 8's default authentication
  def authenticate_user!
    unless current_user
      store_location_for(:user, request.fullpath)
      redirect_to new_session_path, alert: t('zeropoint.authentication.require_sign_in')
    end
  end

  # Get current user from session
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Check if user is signed in
  def user_signed_in?
    current_user.present?
  end

  # Sign in user
  def sign_in(user)
    session[:user_id] = user.id
    session[:signed_in_at] = Time.current
    session[:vortex_session_id] = generate_vortex_session_id(user)

    # Set consciousness context
    set_consciousness_context_for_user(user)

    # Log authentication event
    log_authentication_event(user, 'sign_in')
  end

  # Sign out user
  def sign_out
    user = current_user

    # Clear session
    session.delete(:user_id)
    session.delete(:signed_in_at)
    session.delete(:vortex_session_id)
    session.delete(:consciousness_context)

    # Log authentication event
    log_authentication_event(user, 'sign_out') if user

    # Reset current user
    @current_user = nil
  end

  # Store location for redirect after sign in
  def store_location_for(resource, location)
    session["#{resource}_return_to"] = location
  end

  # Get stored location for redirect
  def stored_location_for(resource)
    session.delete("#{resource}_return_to")
  end

  # Redirect to stored location or default
  def redirect_to_stored_location_or(default)
    redirect_to(stored_location_for(:user) || default)
  end

  # Set consciousness context for the request
  def set_consciousness_context
    return unless Zeropoint.config.consciousness.enabled

    @consciousness_context = {
      observer_id: current_user&.id,
      session_id: session[:vortex_session_id],
      timestamp: Time.current,
      environment: Rails.env,
      request_id: request.request_id,
    }
  end

  # Set consciousness context for a specific user
  def set_consciousness_context_for_user(user)
    return unless Zeropoint.config.consciousness.enabled

    session[:consciousness_context] = {
      observer_id: user.id,
      user_email: user.email,
      user_created_at: user.created_at,
      session_created_at: Time.current,
    }
  end

  # Set vortex context for the request
  def set_vortex_context
    return unless Zeropoint.config.vortex.enabled

    @vortex_context = {
      session_id: session[:vortex_session_id],
      user_id: current_user&.id,
      request_id: request.request_id,
      timestamp: Time.current,
    }
  end

  # Generate vortex session ID
  def generate_vortex_session_id(user)
    return nil unless user && Zeropoint.config.vortex.enabled

    # Use quantum UUID generation if available
    if defined?(Zeropoint::Vortex::QuantumUuid)
      Zeropoint::Vortex::QuantumUuid.generate(
        user_id: user.id,
        timestamp: Time.current,
        entropy_source: 'session'
      )
    else
      SecureRandom.uuid
    end
  end

  # Log authentication events
  def log_authentication_event(user, event_type)
    return unless Rails.logger

    Rails.logger.info(
      "Zeropoint Authentication: #{event_type.upcase} - " \
      "User: #{user&.id} (#{user&.email}) - " \
      "IP: #{request.remote_ip} - " \
      "User-Agent: #{request.user_agent}"
    )
  end

  # Helper methods for views
  def user_signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Vortex authentication helpers
  def vortex_authenticated?
    return false unless Zeropoint.config.vortex.enabled
    return false unless user_signed_in?

    session[:vortex_session_id].present?
  end

  def vortex_session_id
    session[:vortex_session_id]
  end

  # Consciousness authentication helpers
  def consciousness_authenticated?
    return false unless Zeropoint.config.consciousness.enabled
    return false unless user_signed_in?

    session[:consciousness_context].present?
  end

  def consciousness_context
    session[:consciousness_context] || @consciousness_context
  end
end
