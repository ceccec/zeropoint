# frozen_string_literal: true

module Zeropoint
  module Generators
    class UnifiedApiGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      argument :api_name, type: :string, default: 'v1'
      class_option :features, type: :array, default: [], desc: 'Features to enable'
      class_option :backends, type: :hash, default: {}, desc: 'Backend configurations'

      def create_unified_api_structure
        create_api_controller
        create_api_routes
        create_api_concerns
        create_api_services
        create_api_serializers
        create_api_documentation
        create_api_tests
        update_application_config
      end

      private

      def create_api_controller
        template 'unified_api_controller.rb.erb', "app/controllers/api/#{api_name}/unified_controller.rb"
      end

      def create_api_routes
        template 'unified_api_routes.rb.erb', "config/routes/api_#{api_name}.rb"
      end

      def create_api_concerns
        template 'api_concerns/queryable.rb.erb', 'app/controllers/concerns/api/queryable.rb'
        template 'api_concerns/authorizable.rb.erb', 'app/controllers/concerns/api/authorizable.rb'
        template 'api_concerns/cacheable.rb.erb', 'app/controllers/concerns/api/cacheable.rb'
        template 'api_concerns/analytics.rb.erb', 'app/controllers/concerns/api/analytics.rb'
        template 'api_concerns/notifications.rb.erb', 'app/controllers/concerns/api/notifications.rb'
        template 'api_concerns/file_uploads.rb.erb', 'app/controllers/concerns/api/file_uploads.rb'
      end

      def create_api_services
        template 'services/unified_api_service.rb.erb', 'app/services/unified_api_service.rb'
        template 'services/search_service.rb.erb', 'app/services/search_service.rb'
        template 'services/pagination_service.rb.erb', 'app/services/pagination_service.rb'
        template 'services/authorization_service.rb.erb', 'app/services/authorization_service.rb'
        template 'services/cache_service.rb.erb', 'app/services/cache_service.rb'
        template 'services/analytics_service.rb.erb', 'app/services/analytics_service.rb'
        template 'services/notification_service.rb.erb', 'app/services/notification_service.rb'
        template 'services/file_storage_service.rb.erb', 'app/services/file_storage_service.rb'
      end

      def create_api_serializers
        template 'serializers/base_serializer.rb.erb', 'app/serializers/api/base_serializer.rb'
        template 'serializers/error_serializer.rb.erb', 'app/serializers/api/error_serializer.rb'
        template 'serializers/pagination_serializer.rb.erb', 'app/serializers/api/pagination_serializer.rb'
      end

      def create_api_documentation
        template 'documentation/api_docs.md.erb', 'docs/api_documentation.md'
        template 'documentation/swagger.yml.erb', 'config/swagger.yml'
      end

      def create_api_tests
        template 'spec/requests/unified_api_spec.rb.erb', "spec/requests/api/#{api_name}/unified_spec.rb"
        template 'spec/services/unified_api_service_spec.rb.erb', 'spec/services/unified_api_service_spec.rb'
      end

      def update_application_config
        template 'config/application_config.rb.erb', 'config/initializers/api_configuration.rb'
      end

      def enabled_features
        @enabled_features ||= options[:features].presence || default_features
      end

      def default_features
        %w[search pagination authorization cache analytics notifications file_storage]
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

      def api_version
        api_name
      end

      def api_namespace
        "Api::#{api_name.classify}"
      end
    end
  end
end
