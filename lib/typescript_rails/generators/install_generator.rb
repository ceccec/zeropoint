# frozen_string_literal: true

# TypeScript Rails Install Generator
# Generates TypeScript integration files for Rails applications

require 'rails/generators'

module TypeScriptRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Install TypeScript integration for GraphQL UI Layout'

      def create_typescript_config
        template 'typescript.config.js', 'typescript.config.js'
        template 'tsconfig.json', 'tsconfig.json'
        template 'package.json', 'package.json'
      end

      def create_typescript_directories
        empty_directory 'app/javascript/types'
        empty_directory 'app/javascript/components'
        empty_directory 'app/javascript/hooks'
        empty_directory 'app/javascript/utils'
        empty_directory 'app/javascript/services'
      end

      def create_typescript_files
        template 'app/javascript/types/rails-config.ts', 'app/javascript/types/rails-config.ts'
        template 'app/javascript/services/api-client.ts', 'app/javascript/services/api-client.ts'
        template 'app/javascript/hooks/use-rails-api.ts', 'app/javascript/hooks/use-rails-api.ts'
        template 'app/javascript/utils/rails-utils.ts', 'app/javascript/utils/rails-utils.ts'
      end

      def create_application_layout_integration
        template 'app/views/layouts/_typescript_integration.html.erb',
                 'app/views/layouts/_typescript_integration.html.erb'
      end

      def create_initializer
        template 'config/initializers/typescript_rails.rb', 'config/initializers/typescript_rails.rb'
      end

      def add_to_gemfile
        gemfile_path = 'Gemfile'
        unless File.read(gemfile_path).include?('typescript_rails')
          append_file gemfile_path, "\ngem 'typescript_rails', path: 'vendor/gems/typescript_rails'"
        end
      end

      def add_to_application_controller
        inject_into_file 'app/controllers/application_controller.rb',
                         "  include TypeScriptRails::ControllerHelpers\n",
                         after: "class ApplicationController < ActionController::Base\n"
      end

      def add_to_application_helper
        inject_into_file 'app/helpers/application_helper.rb',
                         "  include TypeScriptRails::Helpers\n",
                         after: "module ApplicationHelper\n"
      end

      def add_to_application_layout
        layout_file = 'app/views/layouts/application.html.erb'
        return unless File.exist?(layout_file)

        inject_into_file layout_file,
                         "  <%= render 'layouts/typescript_integration' %>\n",
                         after: "<%= csrf_meta_tags %>\n"
      end

      def create_example_component
        template 'app/javascript/components/ExampleComponent.tsx', 'app/javascript/components/ExampleComponent.tsx'
      end

      def create_example_page
        template 'app/views/pages/typescript_example.html.erb', 'app/views/pages/typescript_example.html.erb'
      end

      def add_route
        route "get 'typescript-example', to: 'pages#typescript_example'"
      end

      def create_pages_controller
        template 'app/controllers/pages_controller.rb', 'app/controllers/pages_controller.rb'
      end

      def show_instructions
        Rails.logger.debug { "\n#{'=' * 60}" }
        Rails.logger.debug 'TypeScript Rails Integration Installed Successfully!'
        Rails.logger.debug '=' * 60
        Rails.logger.debug "\nNext steps:"
        Rails.logger.debug '1. Run: bundle install'
        Rails.logger.debug '2. Run: npm install'
        Rails.logger.debug '3. Run: rails typescript_rails:generate_types'
        Rails.logger.debug '4. Start your Rails server'
        Rails.logger.debug '5. Visit: http://localhost:3000/typescript-example'
        Rails.logger.debug "\nFor more information, see the documentation at:"
        Rails.logger.debug 'https://github.com/your-org/graphql-ui-layout#typescript-integration'
        Rails.logger.debug '=' * 60
      end
    end
  end
end
