# frozen_string_literal: true

# TypeScript Rails Controller Helpers
# Provides controller helpers for TypeScript integration

module TypeScriptRails
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      before_action :set_typescript_headers
      after_action :set_typescript_response_data
    end

    # Set TypeScript-specific headers
    def set_typescript_headers
      response.headers['X-TypeScript-Enabled'] = 'true'
      response.headers['X-API-Version'] = TypeScriptRails.configuration.api_version
    end

    # Set TypeScript response data
    def set_typescript_response_data
      return unless request.format.json?

      # Add TypeScript-specific metadata to JSON responses
      return if response.body.blank?

      begin
        data = JSON.parse(response.body)
        data['_typescript'] = {
          timestamp: Time.current.iso8601,
          version: TypeScriptRails.configuration.api_version,
          cache_ttl: TypeScriptRails.configuration.cache_ttl,
        }
        response.body = data.to_json
      rescue JSON::ParserError
        # Response is not JSON, skip
      end
    end

    # Render TypeScript component
    def render_typescript_component(component_name, props = {})
      render json: {
        component: component_name,
        props: props,
        typescript: true,
      }
    end

    # Render TypeScript widget
    def render_typescript_widget(widget_id, data = {}, options = {})
      render json: {
        widget: widget_id,
        data: data,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript action result
    def render_typescript_action_result(action_id, result = {}, options = {})
      render json: {
        action: action_id,
        result: result,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript search results
    def render_typescript_search_results(query, results, options = {})
      render json: {
        query: query,
        results: results,
        total_count: results.respond_to?(:total_count) ? results.total_count : results.count,
        search_type: 'full_text',
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript file upload result
    def render_typescript_file_upload_result(file_data, options = {})
      render json: {
        file: file_data,
        upload_id: SecureRandom.uuid,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript notification
    def render_typescript_notification(notification_data, options = {})
      render json: {
        notification: notification_data,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript analytics event
    def render_typescript_analytics_event(event_name, properties = {}, options = {})
      render json: {
        analytics_event: event_name,
        properties: properties,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript cache status
    def render_typescript_cache_status(status_data = {}, options = {})
      render json: {
        cache_status: {
          enabled: TypeScriptRails.configuration.enable_offline_support,
          ttl: TypeScriptRails.configuration.cache_ttl,
          auto_refresh: TypeScriptRails.configuration.auto_refresh,
          refresh_interval: TypeScriptRails.configuration.refresh_interval,
        }.merge(status_data),
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript offline data
    def render_typescript_offline_data(data = {}, options = {})
      render json: {
        offline_data: data,
        sync_required: false,
        last_sync: Time.current.iso8601,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript error
    def render_typescript_error(message, status: :unprocessable_entity)
      render json: {
        error: message,
        typescript: true,
        status: status,
      }, status: status
    end

    # Render TypeScript validation errors
    def render_typescript_validation_errors(object, options = {})
      errors = object.errors.full_messages.map do |message|
        {
          message: message,
          field: nil,
          timestamp: Time.current.iso8601,
        }
      end

      render json: {
        validation_errors: errors,
        timestamp: Time.current.iso8601,
      }.merge(options), status: :unprocessable_entity
    end

    # Render TypeScript pagination
    def render_typescript_pagination(collection, options = {})
      pagination_data = {
        current_page: collection.current_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count,
        per_page: collection.limit_value,
        has_next_page: collection.next_page.present?,
        has_previous_page: collection.prev_page.present?,
      }

      render json: {
        pagination: pagination_data,
        data: collection,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript flash messages
    def render_typescript_flash_messages(options = {})
      flash_messages = flash.map do |type, message|
        {
          type: type,
          message: message,
          timestamp: Time.current.iso8601,
        }
      end

      render json: {
        flash_messages: flash_messages,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript user data
    def render_typescript_user_data(options = {})
      return unless current_user

      user_data = {
        id: current_user.id,
        email: current_user.email,
        name: current_user.name,
        roles: current_user.respond_to?(:roles) ? current_user.roles.pluck(:name) : [],
        permissions: current_user.respond_to?(:permissions) ? current_user.permissions : {},
      }

      render json: {
        user: user_data,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript theme data
    def render_typescript_theme_data(options = {})
      return unless defined?(Zeropoint)

      theme_data = Zeropoint::UILayoutController.new.get_theme_data

      render json: {
        theme: theme_data,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript layout data
    def render_typescript_layout_data(page = nil, include_offline_data: false, options: {})
      return unless defined?(Zeropoint)

      layout_data = Zeropoint::UILayoutController.new.get_layout_data(
        page: page,
        include_offline_data: include_offline_data,
      )

      render json: {
        layout: layout_data,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript notification preferences
    def render_typescript_notification_preferences(options = {})
      return unless current_user.respond_to?(:notification_preferences)

      preferences = current_user.notification_preferences

      render json: {
        notification_preferences: preferences,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript file upload progress
    def render_typescript_file_upload_progress(upload_id, progress_data, options = {})
      render json: {
        upload_id: upload_id,
        progress: progress_data,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript search suggestions
    def render_typescript_search_suggestions(query, suggestions, options = {})
      render json: {
        query: query,
        suggestions: suggestions,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript cache keys
    def render_typescript_cache_keys(keys, options = {})
      render json: {
        cache_keys: keys,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript cache stats
    def render_typescript_cache_stats(stats, options = {})
      render json: {
        cache_stats: stats,
        timestamp: Time.current.iso8601,
      }.merge(options)
    end

    # Render TypeScript health check
    def render_typescript_health_check(options = {})
      health_data = {
        status: 'healthy',
        version: TypeScriptRails.configuration.api_version,
        timestamp: Time.current.iso8601,
        services: {
          database: ActiveRecord::Base.connection.active?,
          redis: defined?(Redis) ? Redis.new.ping == 'PONG' : false,
          sidekiq: defined?(Sidekiq) ? Sidekiq.redis(&:ping) == 'PONG' : false,
        },
      }

      render json: health_data.merge(options)
    end

    # Render TypeScript API info
    def render_typescript_api_info(options = {})
      api_info = {
        name: 'GraphQL UI Layout API',
        version: TypeScriptRails.configuration.api_version,
        base_url: TypeScriptRails.configuration.api_base_url,
        timeout: TypeScriptRails.configuration.default_timeout,
        features: {
          offline_support: TypeScriptRails.configuration.enable_offline_support,
          auto_refresh: TypeScriptRails.configuration.auto_refresh,
          caching: true,
          analytics: true,
          notifications: true,
          file_uploads: true,
          search: true,
        },
        timestamp: Time.current.iso8601,
      }

      render json: api_info.merge(options)
    end

    # Handle TypeScript-specific exceptions
    def handle_typescript_exception(exception, options = {})
      error_data = {
        error: exception.message,
        error_type: exception.class.name,
        timestamp: Time.current.iso8601,
      }

      error_data[:backtrace] = exception.backtrace.first(5) if Rails.env.development?

      render json: error_data.merge(options), status: :internal_server_error
    end

    # Validate TypeScript request
    def validate_typescript_request?
      unless request.headers['X-Requested-With'] == 'XMLHttpRequest'
        render_typescript_error('Invalid request type', 'INVALID_REQUEST_TYPE')
        return false
      end

      true
    end

    # Check TypeScript authentication
    def check_typescript_authentication?
      unless current_user
        render_typescript_error('Authentication required', 'AUTHENTICATION_REQUIRED')
        return false
      end

      true
    end

    # Check TypeScript authorization
    def check_typescript_authorization?(action)
      unless current_user.respond_to?(:can?) && current_user.can?(action)
        render_typescript_error('Authorization required', 'AUTHORIZATION_REQUIRED')
        return false
      end

      true
    end

    # Track TypeScript analytics event
    def track_typescript_event(event_name, properties = {})
      return unless defined?(Analytics)

      Analytics.track(
        user_id: current_user&.id,
        event: event_name,
        properties: properties.merge(
          controller: controller_name,
          action: action_name,
          timestamp: Time.current.iso8601,
        ),
      )
    end

    # Send TypeScript notification
    def send_typescript_notification(user, notification_data)
      return unless defined?(NotificationService)

      NotificationService.send(
        user: user,
        notification_type: notification_data[:type],
        title: notification_data[:title],
        message: notification_data[:message],
        data: notification_data[:data] || {},
      )
    end

    # Update TypeScript cache
    def update_typescript_cache(key, value, ttl = nil)
      return unless defined?(Zeropoint)

      ttl ||= TypeScriptRails.configuration.cache_ttl / 1000 # Convert to seconds
      cache_service.write(key, value, expires_in: ttl)
    end

    # Clear TypeScript cache
    def clear_typescript_cache(pattern = nil)
      return unless defined?(Zeropoint)

      if pattern
        cache_service.delete_matched(pattern)
      else
        cache_service.clear
      end
    end

    private

    def cache_service
      @cache_service ||= Zeropoint::Core::CacheService.new(Zeropoint.configuration)
    end

    def current_user
      respond_to?(:current_user) ? current_user : nil
    end
  end
end
