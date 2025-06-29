# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module Zeropoint
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      class_option :skip_authentication, type: :boolean, default: false,
                                        desc: 'Skip Rails 8 authentication setup'
      class_option :skip_vortex, type: :boolean, default: false,
                                desc: 'Skip vortex features setup'
      class_option :skip_graphql, type: :boolean, default: false,
                                 desc: 'Skip GraphQL setup'
      class_option :skip_i18n, type: :boolean, default: false,
                              desc: 'Skip internationalization setup'
      class_option :api_only, type: :boolean, default: false,
                             desc: 'Setup for API-only application'

      def install_zeropoint
        say_status :install, 'Zeropoint gem installation', :green

        # Add Zeropoint to Gemfile
        gem 'zeropoint', path: File.expand_path('../../../..', __FILE__)

        # Install gems
        run 'bundle install'
      end

      def setup_rails_8_authentication
        return if options[:skip_authentication]

        say_status :authentication, 'Setting up Rails 8 authentication', :green

        # Generate Rails 8 authentication
        generate 'authentication'

        # Run migrations
        run 'rails db:migrate'

        # Add registration functionality
        add_registration_controller
        add_registration_views
        add_user_model_enhancements
        add_authentication_routes
      end

      def setup_vortex_features
        return if options[:skip_vortex]

        say_status :vortex, 'Setting up vortex features', :green

        # Create vortex configuration
        create_vortex_config
        create_vortex_initializer
        create_vortex_concerns
        create_vortex_controllers
      end

      def setup_graphql_integration
        return if options[:skip_graphql]

        say_status :graphql, 'Setting up GraphQL integration', :green

        # Add GraphQL gems
        gem 'graphql'
        gem 'graphiql-rails', group: :development

        # Install gems
        run 'bundle install'

        # Generate GraphQL schema
        generate 'graphql:install'

        # Create Zeropoint GraphQL types
        create_graphql_types
        create_graphql_mutations
        create_graphql_queries
      end

      def setup_internationalization
        return if options[:skip_i18n]

        say_status :i18n, 'Setting up internationalization', :green

        create_i18n_config
        create_i18n_concerns
        create_i18n_helpers
      end

      def setup_api_compatibility
        return unless options[:api_only]

        say_status :api, 'Setting up API-only compatibility', :green

        create_api_authentication
        create_api_controllers
        create_api_serializers
      end

      def create_initializers
        say_status :initializers, 'Creating Zeropoint initializers', :green

        create_zeropoint_initializer
        create_consciousness_initializer
        create_vortex_initializer
      end

      def create_concerns
        say_status :concerns, 'Creating Zeropoint concerns', :green

        create_authentication_concern
        create_vortex_concern
        create_consciousness_concern
        create_i18n_concern
      end

      def create_controllers
        say_status :controllers, 'Creating Zeropoint controllers', :green

        create_health_controller
        create_api_controller
        create_graphql_controller
      end

      def create_models
        say_status :models, 'Creating Zeropoint models', :green

        create_user_enhancements
        create_session_enhancements
        create_vortex_models
      end

      def create_views
        say_status :views, 'Creating Zeropoint views', :green

        create_layout_views
        create_authentication_views
        create_graphql_views
      end

      def create_routes
        say_status :routes, 'Setting up Zeropoint routes', :green

        add_zeropoint_routes
        add_graphql_routes
        add_api_routes
      end

      def create_configuration
        say_status :config, 'Creating Zeropoint configuration', :green

        create_zeropoint_config
        create_vortex_config
        create_consciousness_config
      end

      def create_tests
        say_status :tests, 'Creating Zeropoint tests', :green

        create_authentication_tests
        create_vortex_tests
        create_graphql_tests
        create_api_tests
      end

      def create_documentation
        say_status :docs, 'Creating Zeropoint documentation', :green

        create_readme
        create_setup_guide
        create_api_docs
      end

      def finalize_setup
        say_status :finalize, 'Finalizing Zeropoint setup', :green

        # Create database if it doesn't exist
        run 'rails db:create' unless File.exist?('config/database.yml')

        # Run any pending migrations
        run 'rails db:migrate'

        # Create test data
        create_test_data

        # Display setup completion message
        display_setup_completion
      end

      private

      def add_registration_controller
        template 'controllers/users_controller.rb', 'app/controllers/users_controller.rb'
      end

      def add_registration_views
        template 'views/users/new.html.erb', 'app/views/users/new.html.erb'
        template 'views/users/show.html.erb', 'app/views/users/show.html.erb'
      end

      def add_user_model_enhancements
        template 'models/user_enhancements.rb', 'app/models/concerns/user_enhancements.rb'
        template 'models/user.rb', 'app/models/user.rb', force: true
      end

      def add_authentication_routes
        route 'resources :users, only: [:new, :create, :show]'
        route "get 'profile', to: 'users#show'"
      end

      def create_vortex_config
        template 'config/vortex.yml', 'config/vortex.yml'
      end

      def create_vortex_initializer
        template 'initializers/vortex.rb', 'config/initializers/vortex.rb'
      end

      def create_vortex_concerns
        template 'concerns/vortex_authenticatable.rb', 'app/controllers/concerns/vortex_authenticatable.rb'
        template 'concerns/vortex_streamable.rb', 'app/models/concerns/vortex_streamable.rb'
      end

      def create_vortex_controllers
        template 'controllers/vortex_controller.rb', 'app/controllers/vortex_controller.rb'
      end

      def create_graphql_types
        template 'graphql/types/user_type.rb', 'app/graphql/types/user_type.rb'
        template 'graphql/types/session_type.rb', 'app/graphql/types/session_type.rb'
        template 'graphql/types/vortex_type.rb', 'app/graphql/types/vortex_type.rb'
      end

      def create_graphql_mutations
        template 'graphql/mutations/sign_in.rb', 'app/graphql/mutations/sign_in.rb'
        template 'graphql/mutations/sign_up.rb', 'app/graphql/mutations/sign_up.rb'
        template 'graphql/mutations/sign_out.rb', 'app/graphql/mutations/sign_out.rb'
      end

      def create_graphql_queries
        template 'graphql/queries/current_user.rb', 'app/graphql/queries/current_user.rb'
        template 'graphql/queries/vortex_status.rb', 'app/graphql/queries/vortex_status.rb'
      end

      def create_i18n_config
        template 'config/locales/zeropoint.en.yml', 'config/locales/zeropoint.en.yml'
        template 'config/locales/zeropoint.es.yml', 'config/locales/zeropoint.es.yml'
      end

      def create_i18n_concerns
        template 'concerns/i18n_aware.rb', 'app/controllers/concerns/i18n_aware.rb'
      end

      def create_i18n_helpers
        template 'helpers/i18n_helper.rb', 'app/helpers/i18n_helper.rb'
      end

      def create_api_authentication
        template 'controllers/api/authentication_controller.rb', 'app/controllers/api/authentication_controller.rb'
        template 'controllers/api/base_controller.rb', 'app/controllers/api/base_controller.rb'
      end

      def create_api_controllers
        template 'controllers/api/users_controller.rb', 'app/controllers/api/users_controller.rb'
        template 'controllers/api/vortex_controller.rb', 'app/controllers/api/vortex_controller.rb'
      end

      def create_api_serializers
        template 'serializers/user_serializer.rb', 'app/serializers/user_serializer.rb'
        template 'serializers/vortex_serializer.rb', 'app/serializers/vortex_serializer.rb'
      end

      def create_zeropoint_initializer
        template 'initializers/zeropoint.rb', 'config/initializers/zeropoint.rb'
      end

      def create_consciousness_initializer
        template 'initializers/consciousness.rb', 'config/initializers/consciousness.rb'
      end

      def create_authentication_concern
        template 'concerns/zeropoint_authenticatable.rb', 'app/controllers/concerns/zeropoint_authenticatable.rb'
      end

      def create_vortex_concern
        template 'concerns/vortex_enhanced.rb', 'app/models/concerns/vortex_enhanced.rb'
      end

      def create_consciousness_concern
        template 'concerns/consciousness_aware.rb', 'app/controllers/concerns/consciousness_aware.rb'
      end

      def create_i18n_concern
        template 'concerns/i18n_enhanced.rb', 'app/controllers/concerns/i18n_enhanced.rb'
      end

      def create_health_controller
        template 'controllers/health_controller.rb', 'app/controllers/health_controller.rb'
      end

      def create_api_controller
        template 'controllers/api_controller.rb', 'app/controllers/api_controller.rb'
      end

      def create_graphql_controller
        template 'controllers/graphql_controller.rb', 'app/controllers/graphql_controller.rb'
      end

      def create_user_enhancements
        template 'models/user.rb', 'app/models/user.rb', force: true
      end

      def create_session_enhancements
        template 'models/session.rb', 'app/models/session.rb', force: true
      end

      def create_vortex_models
        template 'models/vortex_stream.rb', 'app/models/vortex_stream.rb'
        template 'models/vortex_batch.rb', 'app/models/vortex_batch.rb'
      end

      def create_layout_views
        template 'views/layouts/zeropoint.html.erb', 'app/views/layouts/zeropoint.html.erb'
        template 'views/layouts/api.html.erb', 'app/views/layouts/api.html.erb'
      end

      def create_authentication_views
        template 'views/sessions/new.html.erb', 'app/views/sessions/new.html.erb', force: true
        template 'views/passwords/new.html.erb', 'app/views/passwords/new.html.erb', force: true
        template 'views/passwords/edit.html.erb', 'app/views/passwords/edit.html.erb', force: true
      end

      def create_graphql_views
        template 'views/graphql/playground.html.erb', 'app/views/graphql/playground.html.erb'
      end

      def add_zeropoint_routes
        route "mount Zeropoint::Engine => '/'"
        route "get 'health', to: 'health#show'"
        route "get 'api/health', to: 'health#api'"
      end

      def add_graphql_routes
        route "post '/graphql', to: 'graphql#execute'"
        route "get '/graphql', to: 'graphql#playground'"
      end

      def add_api_routes
        route 'namespace :api do'
        route '  resources :users, only: [:show, :update]'
        route '  resources :vortex, only: [:index, :show]'
        route "  post 'auth/sign_in', to: 'authentication#sign_in'"
        route "  post 'auth/sign_up', to: 'authentication#sign_up'"
        route "  delete 'auth/sign_out', to: 'authentication#sign_out'"
        route 'end'
      end

      def create_zeropoint_config
        template 'config/zeropoint.yml', 'config/zeropoint.yml'
      end

      def create_vortex_config
        template 'config/vortex.yml', 'config/vortex.yml'
      end

      def create_consciousness_config
        template 'config/consciousness.yml', 'config/consciousness.yml'
      end

      def create_authentication_tests
        template 'spec/controllers/users_controller_spec.rb', 'spec/controllers/users_controller_spec.rb'
        template 'spec/controllers/sessions_controller_spec.rb', 'spec/controllers/sessions_controller_spec.rb'
        template 'spec/models/user_spec.rb', 'spec/models/user_spec.rb'
      end

      def create_vortex_tests
        template 'spec/models/vortex_stream_spec.rb', 'spec/models/vortex_stream_spec.rb'
        template 'spec/controllers/vortex_controller_spec.rb', 'spec/controllers/vortex_controller_spec.rb'
      end

      def create_graphql_tests
        template 'spec/graphql/queries/current_user_spec.rb', 'spec/graphql/queries/current_user_spec.rb'
        template 'spec/graphql/mutations/sign_in_spec.rb', 'spec/graphql/mutations/sign_in_spec.rb'
      end

      def create_api_tests
        template 'spec/controllers/api/users_controller_spec.rb', 'spec/controllers/api/users_controller_spec.rb'
        template 'spec/controllers/api/authentication_controller_spec.rb', 'spec/controllers/api/authentication_controller_spec.rb'
      end

      def create_readme
        template 'README.md', 'ZEROPOINT_README.md'
      end

      def create_setup_guide
        template 'docs/SETUP_GUIDE.md', 'docs/SETUP_GUIDE.md'
      end

      def create_api_docs
        template 'docs/API_DOCUMENTATION.md', 'docs/API_DOCUMENTATION.md'
      end

      def create_test_data
        template 'db/seeds/zeropoint_seeds.rb', 'db/seeds/zeropoint_seeds.rb'
        run 'rails db:seed:replant' if File.exist?('db/seeds.rb')
      end

      def display_setup_completion
        say_status :complete, 'Zeropoint installation completed successfully!', :green
        say_status :next, 'Next steps:', :yellow
        say_status :next, '1. Review the generated files and customize as needed', :yellow
        say_status :next, '2. Start your Rails server: rails server', :yellow
        say_status :next, '3. Visit http://localhost:3000 to see your app', :yellow
        say_status :next, '4. Visit http://localhost:3000/graphql for GraphQL playground', :yellow
        say_status :next, '5. Check ZEROPOINT_README.md for detailed documentation', :yellow
      end
    end
  end
end
