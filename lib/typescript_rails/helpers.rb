# frozen_string_literal: true

# TypeScript Rails Helpers
# Provides view helpers for TypeScript integration

module TypeScriptRails
  module Helpers
    # Include the main helpers
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::JavaScriptHelper

    # TypeScript client initialization helper
    def typescript_client_init(options = {})
      config = TypeScriptRails.api_config.merge(options)

      content_tag :script, type: 'application/json', id: 'typescript-client-config' do
        config.to_json
      end
    end

    # UI Layout data helper
    def typescript_ui_layout_data(page = nil, include_offline_data: false)
      return unless defined?(Zeropoint)

      Zeropoint::UILayoutController.new.get_layout_data(
        page: page,
        include_offline_data: include_offline_data,
      )
    end

    # Theme data helper
    def typescript_theme_data
      return unless defined?(Zeropoint)

      theme_data = Zeropoint::UILayoutController.new.get_theme_data

      content_tag :script, type: 'application/json', id: 'theme-data' do
        theme_data.to_json
      end
    end

    # User data helper
    def typescript_user_data
      return unless current_user

      user_data = {
        id: current_user.id,
        email: current_user.email,
        name: current_user.name,
        roles: current_user.respond_to?(:roles) ? current_user.roles.pluck(:name) : [],
        permissions: current_user.respond_to?(:permissions) ? current_user.permissions : {},
      }

      content_tag :script, type: 'application/json', id: 'user-data' do
        user_data.to_json
      end
    end

    # CSRF token helper
    def typescript_csrf_token
      content_tag :meta, name: 'csrf-token', content: form_authenticity_token
    end

    # TypeScript component wrapper
    def typescript_component(component_name, props = {}, options = {})
      data_attributes = {
        'typescript-component': component_name,
        'typescript-props': props.to_json,
      }.merge(options[:data] || {})

      content_tag :div, options.merge(data: data_attributes) do
        yield if block_given?
      end
    end

    # TypeScript widget wrapper
    def typescript_widget(widget_id, options = {})
      data_attributes = {
        'typescript-widget': widget_id,
      }.merge(options[:data] || {})

      content_tag :div, options.merge(data: data_attributes) do
        yield if block_given?
      end
    end

    # TypeScript action wrapper
    def typescript_action(action_id, options = {})
      data_attributes = {
        'typescript-action': action_id,
      }.merge(options[:data] || {})

      content_tag :button, options.merge(data: data_attributes) do
        yield if block_given?
      end
    end

    # TypeScript form wrapper
    def typescript_form(form_name, options = {})
      data_attributes = {
        'typescript-form': form_name,
      }.merge(options[:data] || {})

      form_with options.merge(data: data_attributes) do |form|
        yield form if block_given?
      end
    end

    # TypeScript search wrapper
    def typescript_search(search_type = 'global', options = {})
      data_attributes = {
        'typescript-search': search_type,
      }.merge(options[:data] || {})

      content_tag :div, options.merge(data: data_attributes) do
        yield if block_given?
      end
    end

    # TypeScript file upload wrapper
    def typescript_file_upload(options = {})
      data_attributes = {
        'typescript-file-upload': true,
      }.merge(options[:data] || {})

      content_tag :div, options.merge(data: data_attributes) do
        yield if block_given?
      end
    end

    # TypeScript notification wrapper
    def typescript_notifications(options = {})
      data_attributes = {
        'typescript-notifications': true,
      }.merge(options[:data] || {})

      content_tag :div, options.merge(data: data_attributes) do
        yield if block_given?
      end
    end

    # TypeScript analytics wrapper
    def typescript_analytics(event_name, properties = {}, options = {})
      data_attributes = {
        'typescript-analytics': event_name,
        'typescript-analytics-props': properties.to_json,
      }.merge(options[:data] || {})

      content_tag :div, options.merge(data: data_attributes) do
        yield if block_given?
      end
    end

    # TypeScript cache management wrapper
    def typescript_cache_manager(options = {})
      data_attributes = {
        'typescript-cache-manager': true,
      }.merge(options[:data] || {})

      content_tag :div, options.merge(data: data_attributes) do
        yield if block_given?
      end
    end

    # TypeScript offline indicator
    def typescript_offline_indicator(options = {})
      data_attributes = {
        'typescript-offline-indicator': true,
      }.merge(options[:data] || {})

      content_tag :div, options.merge(data: data_attributes) do
        yield if block_given?
      end
    end

    # TypeScript loading spinner
    def typescript_loading_spinner(options = {})
      data_attributes = {
        'typescript-loading-spinner': true,
      }.merge(options[:data] || {})

      content_tag :div, options.merge(data: data_attributes) do
        yield if block_given?
      end
    end

    # TypeScript error boundary
    def typescript_error_boundary(options = {})
      data_attributes = {
        'typescript-error-boundary': true,
      }.merge(options[:data] || {})

      content_tag :div, options.merge(data: data_attributes) do
        yield if block_given?
      end
    end

    # TypeScript route helper
    def typescript_route(route_name, *args)
      Rails.application.routes.url_helpers.send("#{route_name}_path", *args)
    end

    # TypeScript asset helper
    def typescript_asset_path(asset_name)
      asset_path(asset_name)
    end

    # TypeScript image helper
    def typescript_image_path(image_name)
      image_path(image_name)
    end

    # TypeScript stylesheet helper
    def typescript_stylesheet_path(stylesheet_name)
      stylesheet_path(stylesheet_name)
    end

    # TypeScript javascript helper
    def typescript_javascript_path(javascript_name)
      javascript_path(javascript_name)
    end

    # TypeScript flash messages helper
    def typescript_flash_messages
      flash_messages = flash.map do |type, message|
        {
          type: type,
          message: message,
          timestamp: Time.current.iso8601,
        }
      end

      content_tag :script, type: 'application/json', id: 'flash-messages' do
        flash_messages.to_json
      end
    end

    # TypeScript validation errors helper
    def typescript_validation_errors(object)
      return unless object&.errors&.any?

      errors = object.errors.full_messages.map do |message|
        {
          message: message,
          timestamp: Time.current.iso8601,
        }
      end

      content_tag :script, type: 'application/json', id: 'validation-errors' do
        errors.to_json
      end
    end

    # TypeScript pagination helper
    def typescript_pagination_info(collection)
      return unless collection.respond_to?(:current_page)

      pagination_info = {
        current_page: collection.current_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count,
        per_page: collection.limit_value,
        has_next_page: collection.next_page.present?,
        has_previous_page: collection.prev_page.present?,
      }

      content_tag :script, type: 'application/json', id: 'pagination-info' do
        pagination_info.to_json
      end
    end

    # TypeScript search results helper
    def typescript_search_results(results, query)
      search_results = {
        query: query,
        results: results,
        total_count: results.respond_to?(:total_count) ? results.total_count : results.count,
        search_type: 'full_text',
      }

      content_tag :script, type: 'application/json', id: 'search-results' do
        search_results.to_json
      end
    end

    # TypeScript file upload progress helper
    def typescript_file_upload_progress(upload_id)
      data_attributes = {
        'typescript-upload-progress': upload_id,
      }

      content_tag :div, data: data_attributes do
        yield if block_given?
      end
    end

    # TypeScript notification preferences helper
    def typescript_notification_preferences
      return unless current_user.respond_to?(:notification_preferences)

      preferences = current_user.notification_preferences

      content_tag :script, type: 'application/json', id: 'notification-preferences' do
        preferences.to_json
      end
    end

    # TypeScript cache status helper
    def typescript_cache_status
      cache_status = {
        enabled: TypeScriptRails.configuration.enable_offline_support,
        ttl: TypeScriptRails.configuration.cache_ttl,
        auto_refresh: TypeScriptRails.configuration.auto_refresh,
        refresh_interval: TypeScriptRails.configuration.refresh_interval,
      }

      content_tag :script, type: 'application/json', id: 'cache-status' do
        cache_status.to_json
      end
    end

    # Generate TypeScript-safe HTML attributes
    def typescript_attributes(attributes = {})
      attributes.transform_keys(&:to_s).transform_values(&:to_s)
    end

    # Generate TypeScript component props
    def typescript_props(props = {})
      props.deep_transform_keys(&:camelize).to_json
    end

    # Generate TypeScript-safe class names
    def typescript_class_names(*classes)
      classes.compact.join(' ')
    end

    # Generate TypeScript event handlers
    def typescript_event_handler(event, handler)
      { "on#{event.camelize}" => handler }
    end

    # Generate TypeScript ref
    def typescript_ref(name)
      "ref={#{name}}"
    end

    # Generate TypeScript state
    def typescript_state(initial_value)
      "useState(#{initial_value.to_json})"
    end

    # Generate TypeScript effect
    def typescript_effect(dependencies = [])
      "useEffect(() => {}, [#{dependencies.join(', ')}])"
    end

    # Generate TypeScript context
    def typescript_context(name)
      "useContext(#{name}Context)"
    end

    # Generate TypeScript reducer
    def typescript_reducer(name, initial_state = {})
      "useReducer(#{name}Reducer, #{initial_state.to_json})"
    end

    # Generate TypeScript callback
    def typescript_callback(callback, dependencies = [])
      "useCallback(#{callback}, [#{dependencies.join(', ')}])"
    end

    # Generate TypeScript memo
    def typescript_memo(component, props = {})
      "React.memo(#{component}, #{props.to_json})"
    end

    private

    def current_user
      respond_to?(:current_user) ? current_user : nil
    end
  end
end
