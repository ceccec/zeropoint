# frozen_string_literal: true

require 'rails/generators'

module Zeropoint
  module Generators
    class BackendGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      class_option :skip_models, type: :boolean, default: false, desc: 'Skip model generation'
      class_option :skip_controllers, type: :boolean, default: false, desc: 'Skip controller generation'
      class_option :skip_services, type: :boolean, default: false, desc: 'Skip service generation'
      class_option :skip_graphql, type: :boolean, default: false, desc: 'Skip GraphQL schema generation'
      class_option :skip_api, type: :boolean, default: false, desc: 'Skip API endpoints generation'

      desc 'Install Zeropoint backend components (models, controllers, services, GraphQL, API)'

      def install_backend
        say_status :install, 'Zeropoint Backend Components', :green

        # Create models
        generate_models unless options[:skip_models]

        # Create controllers
        generate_controllers unless options[:skip_controllers]

        # Create services
        generate_services unless options[:skip_services]

        # Create GraphQL schema
        generate_graphql_schema unless options[:skip_graphql]

        # Create API endpoints
        generate_api_endpoints unless options[:skip_api]

        # Create database migrations
        generate_migrations

        # Display completion message
        display_completion_message
      end

      private

      def generate_models
        say_status :create, 'Models', :blue

        template 'models/zeropoint_config.rb', 'app/models/zeropoint_config.rb'
        template 'models/concerns/zeropoint_integration.rb', 'app/models/concerns/zeropoint_integration.rb'
        template 'models/concerns/zeropoint_searchable.rb', 'app/models/concerns/zeropoint_searchable.rb'
        template 'models/concerns/zeropoint_filterable.rb', 'app/models/concerns/zeropoint_filterable.rb'
        template 'models/concerns/zeropoint_analytics.rb', 'app/models/concerns/zeropoint_analytics.rb'
      end

      def generate_controllers
        say_status :create, 'Controllers', :blue

        template 'controllers/zeropoint_controller.rb', 'app/controllers/zeropoint_controller.rb'
        template 'controllers/api/v1/zeropoint_controller.rb', 'app/controllers/api/v1/zeropoint_controller.rb'
        template 'controllers/api/v1/zeropoint_analytics_controller.rb', 'app/controllers/api/v1/zeropoint_analytics_controller.rb'
        template 'controllers/api/v1/zeropoint_stream_controller.rb', 'app/controllers/api/v1/zeropoint_stream_controller.rb'
      end

      def generate_services
        say_status :create, 'Services', :blue

        template 'services/zeropoint_service.rb', 'app/services/zeropoint_service.rb'
        template 'services/zeropoint_analytics_service.rb', 'app/services/zeropoint_analytics_service.rb'
        template 'services/zeropoint_stream_service.rb', 'app/services/zeropoint_stream_service.rb'
        template 'services/zeropoint_cache_service.rb', 'app/services/zeropoint_cache_service.rb'
        template 'services/zeropoint_search_service.rb', 'app/services/zeropoint_search_service.rb'
      end

      def generate_graphql_schema
        say_status :create, 'GraphQL Schema', :blue

        template 'graphql/types/zeropoint_type.rb', 'app/graphql/types/zeropoint_type.rb'
        template 'graphql/types/zeropoint_analytics_type.rb', 'app/graphql/types/zeropoint_analytics_type.rb'
        template 'graphql/mutations/zeropoint_mutation.rb', 'app/graphql/mutations/zeropoint_mutation.rb'
        template 'graphql/mutations/zeropoint_analytics_mutation.rb', 'app/graphql/mutations/zeropoint_analytics_mutation.rb'
        template 'graphql/queries/zeropoint_query.rb', 'app/graphql/queries/zeropoint_query.rb'
        template 'graphql/queries/zeropoint_analytics_query.rb', 'app/graphql/queries/zeropoint_analytics_query.rb'
      end

      def generate_api_endpoints
        say_status :create, 'API Endpoints', :blue

        template 'api/v1/zeropoint_serializer.rb', 'app/serializers/api/v1/zeropoint_serializer.rb'
        template 'api/v1/zeropoint_analytics_serializer.rb', 'app/serializers/api/v1/zeropoint_analytics_serializer.rb'
        template 'api/v1/zeropoint_stream_serializer.rb', 'app/serializers/api/v1/zeropoint_stream_serializer.rb'
      end

      def generate_migrations
        say_status :create, 'Database Migrations', :blue

        generate :migration, 'CreateZeropointConfigs'
        generate :migration, 'CreateZeropointAnalytics'
        generate :migration, 'CreateZeropointStreams'
        generate :migration, 'CreateZeropointCache'
      end

      def display_completion_message
        say_status :complete, 'Zeropoint Backend Installation', :green

        Rails.logger.debug "\n" + '='*60
        Rails.logger.debug '🎯 Zeropoint Backend Installation Complete!'
        Rails.logger.debug '='*60
        Rails.logger.debug "\nBackend components installed:"
        Rails.logger.debug '✓ Models with concerns'
        Rails.logger.debug '✓ Controllers (main + API)'
        Rails.logger.debug '✓ Services (core + analytics + stream + cache + search)'
        Rails.logger.debug '✓ GraphQL schema (types + mutations + queries)'
        Rails.logger.debug '✓ API serializers'
        Rails.logger.debug '✓ Database migrations'
        Rails.logger.debug "\nNext steps:"
        Rails.logger.debug '1. Run migrations: rails db:migrate'
        Rails.logger.debug '2. Configure your database settings'
        Rails.logger.debug '3. Set up caching (Redis recommended)'
        Rails.logger.debug '4. Test the API endpoints'
        Rails.logger.debug '5. Install frontend: rails generate zeropoint:frontend'
        Rails.logger.debug '='*60
      end
    end
  end
end
