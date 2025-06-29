# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit if defined?(PaperTrail)
  before_action :track_page_view if defined?(Ahoy)

  # Include GraphQL UI Layout helpers
  include Zeropoint::Helpers::LayoutHelper
  include Zeropoint::Helpers::NavigationHelper
  include Zeropoint::Helpers::WidgetHelper

  # Include custom helpers
  include ApplicationHelper
  include FormHelper
  include LayoutHelper

  # Include configurable authentication and authorization
  include Authenticatable
  include Authorizable

  # Rails 8 Authentication
  helper_method :current_user, :user_signed_in?

  # DRY: Centralized user lookup
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    redirect_to login_path, alert: t('demo.please_sign_in') unless current_user
  end

  # Track page views for analytics
  def track_page_view
    return unless defined?(Ahoy)

    ahoy.track 'Page View', {
      page: request.path,
      referrer: request.referer,
      user_agent: request.user_agent
    }
  end

  # Handle exceptions
  rescue_from StandardError, with: :handle_standard_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from Pundit::NotAuthorizedError, with: :handle_unauthorized

  def handle_standard_error(exception)
    Rails.logger.error "Application Error: #{exception.message}"
    Rails.logger.error exception.backtrace.join("\n")
    respond_to do |format|
      format.html { render 'errors/500', status: :internal_server_error }
      format.json { render json: { error: 'Internal server error' }, status: :internal_server_error }
    end
  end

  def handle_not_found(_exception)
    respond_to do |format|
      format.html { render 'errors/404', status: :not_found }
      format.json { render json: { error: 'Not found' }, status: :not_found }
    end
  end

  def handle_unauthorized(_exception)
    respond_to do |format|
      format.html { redirect_to root_path, alert: t('demo.not_authorized') }
      format.json { render json: { error: t('demo.not_authorized') }, status: :unauthorized }
    end
  end

  # Service accessors
  def analytics_service
    @analytics_service ||= AnalyticsService.new
  end

  def search_service
    @search_service ||= SearchService.new
  end

  def post_service
    @post_service ||= PostService.new(current_user)
  end

  def user_service
    @user_service ||= UserService.new(current_user)
  end

  def authorization_service
    @authorization_service ||= Rails.application.config.authorization_service.dup.tap do |service|
      # Set the current user for this request
      service.instance_variable_set(:@user, current_user)
    end
  end

  # Override authentication strategy based on request type
  def find_current_user
    # Try different authentication strategies based on request
    if api_request?
      authenticate_with_token! || authenticate_with_api_key!
    elsif oauth_request?
      authenticate_with_oauth!
    else
      authenticate_with_session!
    end
  end

  private

  def api_request?
    request.format.json? || controller_path.start_with?('api/')
  end

  def oauth_request?
    request.headers['Authorization']&.start_with?('OAuth')
  end

  # Override authorization for application-wide rules
  def skip_authorization?
    # Skip authorization for public pages
    public_actions = %w[home about contact]
    public_actions.include?(action_name)
  end

  # Authorization helpers for views
  def can?(action, resource = nil)
    authorization_service.can?(action, resource)
  end

  def cannot?(action, resource = nil)
    authorization_service.cannot?(action, resource)
  end

  def owns?(resource)
    authorization_service.owns?(resource)
  end

  helper_method :can?, :cannot?, :owns?
end
