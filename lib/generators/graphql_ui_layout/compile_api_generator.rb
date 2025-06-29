# frozen_string_literal: true

module Zeropoint
  module Generators
    class CompileApiGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      argument :api_name, type: :string, default: 'v1'
      class_option :features, type: :array, default: [], desc: 'Features to enable'
      class_option :backends, type: :hash, default: {}, desc: 'Backend configurations'
      class_option :services, type: :array, default: [], desc: 'Services to include'
      class_option :endpoints, type: :array, default: [], desc: 'Endpoints to include'

      def compile_unified_api
        create_api_structure
        generate_services
        create_api_controller
        create_api_routes
        create_api_documentation
        create_api_tests
        update_application_config
        create_api_client
        create_api_examples
      end

      private

      def create_api_structure
        empty_directory "app/controllers/api/#{api_name}"
        empty_directory "app/services/api/#{api_name}"
        empty_directory "app/serializers/api/#{api_name}"
        empty_directory "spec/requests/api/#{api_name}"
        empty_directory "spec/services/api/#{api_name}"
        empty_directory "docs/api/#{api_name}"
      end

      def generate_services
        enabled_services.each do |service_name|
          generate_service(service_name)
        end
      end

      def generate_service(service_name)
        backend = backend_configs[service_name.to_sym] || 'default'

        generate 'zeropoint:service', service_name,
                 backend: backend,
                 features: enabled_features_for_service(service_name),
                 config: service_config_for(service_name)
      end

      def create_api_controller
        template 'compiled_api_controller.rb.erb', "app/controllers/api/#{api_name}/compiled_controller.rb"
      end

      def create_api_routes
        template 'compiled_api_routes.rb.erb', "config/routes/api_#{api_name}_compiled.rb"
      end

      def create_api_documentation
        template 'compiled_api_docs.md.erb', "docs/api/#{api_name}/compiled_api.md"
        template 'compiled_swagger.yml.erb', "config/swagger_#{api_name}.yml"
      end

      def create_api_tests
        template 'spec/requests/compiled_api_spec.rb.erb', "spec/requests/api/#{api_name}/compiled_spec.rb"
        template 'spec/services/compiled_api_service_spec.rb.erb',
                 "spec/services/api/#{api_name}/compiled_service_spec.rb"
      end

      def update_application_config
        template 'config/compiled_api_config.rb.erb', "config/initializers/api_#{api_name}_compiled.rb"
      end

      def create_api_client
        template 'api_client/compiled_client.rb.erb', "app/clients/api/#{api_name}_client.rb"
        template 'api_client/compiled_client_spec.rb.erb', "spec/clients/api/#{api_name}_client_spec.rb"
      end

      def create_api_examples
        template 'examples/compiled_api_examples.rb.erb', "examples/api/#{api_name}_examples.rb"
        template 'examples/compiled_api_usage.md.erb', "docs/api/#{api_name}/usage_examples.md"
      end

      def enabled_services
        @enabled_services ||= options[:services].presence || default_services
      end

      def default_services
        %w[search pagination authorization cache analytics notifications file_storage]
      end

      def enabled_features
        @enabled_features ||= options[:features].presence || default_features
      end

      def default_features
        %w[crud search bulk_operations export_import cache_management analytics tracking notifications file_uploads]
      end

      def backend_configs
        @backend_configs ||= options[:backends].presence || default_backend_configs
      end

      def default_backend_configs
        {
          search: 'pg_search',
          pagination: 'kaminari',
          authorization: 'pundit',
          cache: 'redis',
          analytics: 'ahoy',
          notifications: 'noticed',
          file_storage: 'carrierwave',
        }
      end

      def enabled_endpoints
        @enabled_endpoints ||= options[:endpoints].presence || default_endpoints
      end

      def default_endpoints
        %w[health schema crud search bulk export import cache analytics notifications uploads]
      end

      def enabled_features_for_service(service_name)
        case service_name
        when 'search'
          %w[basic_search advanced_search field_search suggestions]
        when 'pagination'
          %w[basic_pagination metadata_pagination filtered_pagination]
        when 'authorization'
          %w[basic_auth scope_auth permission_check role_based]
        when 'cache'
          %w[basic_cache stats_cache invalidation_cache]
        when 'analytics'
          %w[event_tracking page_tracking user_tracking dashboard]
        when 'notifications'
          %w[send_notifications get_notifications mark_read delete_notifications]
        when 'file_storage'
          %w[upload_files download_files delete_files get_urls]
        else
          []
        end
      end

      def service_config_for(service_name)
        backend = backend_configs[service_name.to_sym]
        {
          backend: backend,
          features: enabled_features_for_service(service_name),
          config: backend_config_for(service_name, backend),
        }
      end

      def backend_config_for(service_name, backend)
        case service_name
        when 'search'
          search_backend_config(backend)
        when 'pagination'
          pagination_backend_config(backend)
        when 'authorization'
          authorization_backend_config(backend)
        when 'cache'
          cache_backend_config(backend)
        when 'analytics'
          analytics_backend_config(backend)
        when 'notifications'
          notification_backend_config(backend)
        when 'file_storage'
          file_storage_backend_config(backend)
        else
          {}
        end
      end

      def search_backend_config(backend)
        case backend
        when 'pg_search'
          { multi_search: true, trigram: true }
        when 'searchkick'
          { index_prefix: 'app', language: 'english' }
        when 'elasticsearch'
          { host: 'localhost:9200', index: 'app' }
        else
          {}
        end
      end

      def pagination_backend_config(backend)
        case backend
        when 'kaminari'
          { default_per_page: 25, max_per_page: 100 }
        when 'will_paginate'
          { per_page: 25, max_per_page: 100 }
        else
          { default_per_page: 25, max_per_page: 100 }
        end
      end

      def authorization_backend_config(backend)
        case backend
        when 'pundit'
          { policy_suffix: 'Policy', policy_namespace: 'Policies' }
        when 'cancancan'
          { ability_class: 'Ability', role_class: 'Role' }
        else
          {}
        end
      end

      def cache_backend_config(backend)
        case backend
        when 'redis'
          { url: 'redis://localhost:6379/0', namespace: 'app' }
        when 'memcached'
          { servers: [ 'localhost:11211' ], namespace: 'app' }
        else
          { namespace: 'app' }
        end
      end

      def analytics_backend_config(backend)
        case backend
        when 'ahoy'
          { track_visits_immediately: true, track_bots: false }
        when 'mixpanel'
          { token: 'YOUR_TOKEN', track_pageviews: true }
        else
          {}
        end
      end

      def notification_backend_config(backend)
        case backend
        when 'noticed'
          { delivery_methods: [ :database, :email ], async: true }
        when 'mailboxer'
          { notifications: true, conversations: false }
        else
          {}
        end
      end

      def file_storage_backend_config(backend)
        case backend
        when 'carrierwave'
          { storage: :file, cache_dir: 'uploads/tmp' }
        when 'active_storage'
          { service: :local, variant_processor: :mini_magick }
        when 'shrine'
          { storage: :file, cache: :file }
        else
          {}
        end
      end

      def api_version
        api_name
      end

      def api_namespace
        "Api::#{api_name.classify}"
      end

      def service_classes
        enabled_services.map { |s| "#{s.classify}Service" }
      end

      def endpoint_methods
        enabled_endpoints.map(&:to_sym)
      end

      def compile_services
        enabled_services.map do |service|
          {
            name: service,
            class: "#{service.classify}Service",
            backend: backend_configs[service.to_sym],
            features: enabled_features_for_service(service),
          }
        end
      end

      def compile_endpoints
        enabled_endpoints.map do |endpoint|
          {
            name: endpoint,
            method: endpoint_method_for(endpoint),
            path: endpoint_path_for(endpoint),
            features: endpoint_features_for(endpoint),
          }
        end
      end

      def endpoint_method_for(endpoint)
        case endpoint
        when 'health', 'schema'
          :get
        when 'crud'
          %i[get post put patch delete]
        when 'search', 'bulk', 'export', 'import', 'analytics', 'notifications', 'uploads'
          [ :get, :post ]
        when 'cache'
          [ :get, :delete ]
        else
          :get
        end
      end

      def endpoint_path_for(endpoint)
        case endpoint
        when 'health'
          'health'
        when 'schema'
          'schema'
        when 'crud'
          ':model'
        when 'search'
          ':model/search'
        when 'bulk'
          ':model/bulk'
        when 'export'
          ':model/export'
        when 'import'
          ':model/import'
        when 'cache'
          'cache'
        when 'analytics'
          'analytics'
        when 'notifications'
          'notifications'
        when 'uploads'
          'upload'
        else
          endpoint
        end
      end

      def endpoint_features_for(endpoint)
        case endpoint
        when 'health', 'schema'
          []
        when 'crud'
          %w[create read update delete]
        when 'search'
          %w[basic_search advanced_search]
        when 'bulk'
          %w[bulk_create bulk_update bulk_delete]
        when 'export', 'import'
          %w[export_csv export_json import_csv import_json]
        when 'cache'
          %w[cache_stats cache_invalidate]
        when 'analytics'
          %w[event_tracking dashboard]
        when 'notifications'
          %w[send_notifications get_notifications]
        when 'uploads'
          %w[file_upload file_download]
        else
          []
        end
      end
    end
  end
end
