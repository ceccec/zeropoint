# frozen_string_literal: true

require 'rails/generators'

module Zeropoint
  module Generators
    class FrontendGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      class_option :skip_javascript, type: :boolean, default: false, desc: 'Skip JavaScript components'
      class_option :skip_stylesheets, type: :boolean, default: false, desc: 'Skip stylesheet generation'
      class_option :skip_stimulus, type: :boolean, default: false, desc: 'Skip Stimulus controllers'
      class_option :skip_typescript, type: :boolean, default: false, desc: 'Skip TypeScript definitions'
      class_option :skip_components, type: :boolean, default: false, desc: 'Skip React/Vue components'

      desc 'Install Zeropoint frontend components (JavaScript, CSS, Stimulus, TypeScript, Components)'

      def install_frontend
        say_status :install, 'Zeropoint Frontend Components', :green

        # Create JavaScript components
        generate_javascript_components unless options[:skip_javascript]

        # Create CSS/SCSS files
        generate_stylesheets unless options[:skip_stylesheets]

        # Create Stimulus controllers
        generate_stimulus_controllers unless options[:skip_stimulus]

        # Create TypeScript definitions
        generate_typescript_definitions unless options[:skip_typescript]

        # Create React/Vue components
        generate_components unless options[:skip_components]

        # Update application files
        update_application_files

        # Display completion message
        display_completion_message
      end

      private

      def generate_javascript_components
        say_status :create, 'JavaScript Components', :blue

        template 'javascript/zeropoint.js', 'app/javascript/zeropoint.js'
        template 'javascript/components/zeropoint_component.js', 'app/javascript/components/zeropoint_component.js'
        template 'javascript/components/zeropoint_dashboard.js', 'app/javascript/components/zeropoint_dashboard.js'
        template 'javascript/components/zeropoint_analytics.js', 'app/javascript/components/zeropoint_analytics.js'
        template 'javascript/components/zeropoint_stream.js', 'app/javascript/components/zeropoint_stream.js'
      end

      def generate_stylesheets
        say_status :create, 'Stylesheets', :blue

        template 'stylesheets/zeropoint.scss', 'app/assets/stylesheets/zeropoint.scss'
        template 'stylesheets/components/_zeropoint_components.scss', 'app/assets/stylesheets/components/_zeropoint_components.scss'
        template 'stylesheets/components/_zeropoint_dashboard.scss', 'app/assets/stylesheets/components/_zeropoint_dashboard.scss'
        template 'stylesheets/components/_zeropoint_analytics.scss', 'app/assets/stylesheets/components/_zeropoint_analytics.scss'
        template 'stylesheets/components/_zeropoint_stream.scss', 'app/assets/stylesheets/components/_zeropoint_stream.scss'
        template 'stylesheets/utilities/_zeropoint_utilities.scss', 'app/assets/stylesheets/utilities/_zeropoint_utilities.scss'
      end

      def generate_stimulus_controllers
        say_status :create, 'Stimulus Controllers', :blue

        template 'javascript/controllers/zeropoint_controller.js', 'app/javascript/controllers/zeropoint_controller.js'
        template 'javascript/controllers/zeropoint_analytics_controller.js', 'app/javascript/controllers/zeropoint_analytics_controller.js'
        template 'javascript/controllers/zeropoint_stream_controller.js', 'app/javascript/controllers/zeropoint_stream_controller.js'
        template 'javascript/controllers/zeropoint_dashboard_controller.js', 'app/javascript/controllers/zeropoint_dashboard_controller.js'
        template 'javascript/controllers/zeropoint_cache_controller.js', 'app/javascript/controllers/zeropoint_cache_controller.js'
      end

      def generate_typescript_definitions
        say_status :create, 'TypeScript Definitions', :blue

        template 'typescript/zeropoint.d.ts', 'app/typescript/zeropoint.d.ts'
        template 'typescript/components/zeropoint_component.d.ts', 'app/typescript/components/zeropoint_component.d.ts'
        template 'typescript/controllers/zeropoint_controller.d.ts', 'app/typescript/controllers/zeropoint_controller.d.ts'
        template 'typescript/services/zeropoint_service.d.ts', 'app/typescript/services/zeropoint_service.d.ts'
      end

      def generate_components
        say_status :create, 'React/Vue Components', :blue

        template 'components/ZeropointDashboard.jsx', 'app/javascript/components/ZeropointDashboard.jsx'
        template 'components/ZeropointAnalytics.jsx', 'app/javascript/components/ZeropointAnalytics.jsx'
        template 'components/ZeropointStream.jsx', 'app/javascript/components/ZeropointStream.jsx'
        template 'components/ZeropointCache.jsx', 'app/javascript/components/ZeropointCache.jsx'
      end

      def update_application_files
        say_status :update, 'Application Files', :blue

        # Update application.js
        update_application_js

        # Update application.scss
        update_application_scss

        # Update importmap (if using importmaps)
        update_importmap if importmap_available?
      end

      def update_application_js
        application_js = 'app/javascript/application.js'
        if File.exist?(application_js)
          content = File.read(application_js)
          unless content.include?('zeropoint')
            inject_into_file application_js, before: '// Configure your import map in config/importmap.rb' do
              "// Zeropoint Framework\nimport 'zeropoint'\nimport 'controllers'\n\n"
            end
          end
        end
      end

      def update_application_scss
        application_scss = 'app/assets/stylesheets/application.scss'
        if File.exist?(application_scss)
          content = File.read(application_scss)
          unless content.include?('zeropoint')
            inject_into_file application_scss, at_end: true do
              "\n// Zeropoint Framework\n@import 'zeropoint';\n"
            end
          end
        end
      end

      def update_importmap
        importmap_file = 'config/importmap.rb'
        if File.exist?(importmap_file)
          content = File.read(importmap_file)
          unless content.include?('zeropoint')
            inject_into_file importmap_file, at_end: true do
              "\n# Zeropoint Framework\npin 'zeropoint', to: 'zeropoint.js'\n"
            end
          end
        end
      end

      def importmap_available?
        File.exist?('config/importmap.rb')
      end

      def display_completion_message
        say_status :complete, 'Zeropoint Frontend Installation', :green

        Rails.logger.debug "\n" + '='*60
        Rails.logger.debug '🎨 Zeropoint Frontend Installation Complete!'
        Rails.logger.debug '='*60
        Rails.logger.debug "\nFrontend components installed:"
        Rails.logger.debug '✓ JavaScript components and utilities'
        Rails.logger.debug '✓ SCSS stylesheets with components'
        Rails.logger.debug '✓ Stimulus controllers for interactivity'
        Rails.logger.debug '✓ TypeScript definitions for type safety'
        Rails.logger.debug '✓ React/Vue components (if applicable)'
        Rails.logger.debug '✓ Application file updates'
        Rails.logger.debug "\nNext steps:"
        Rails.logger.debug '1. Start your Rails server: rails server'
        Rails.logger.debug '2. Visit http://localhost:3000/zeropoint to see the dashboard'
        Rails.logger.debug '3. Check the browser console for any JavaScript errors'
        Rails.logger.debug '4. Customize the styles in app/assets/stylesheets/zeropoint.scss'
        Rails.logger.debug '5. Add your own components to app/javascript/components/'
        Rails.logger.debug "\nFor development:"
        Rails.logger.debug '- Use browser dev tools to debug JavaScript'
        Rails.logger.debug '- Check the Stimulus controllers in app/javascript/controllers/'
        Rails.logger.debug '- Modify TypeScript definitions as needed'
        Rails.logger.debug '='*60
      end
    end
  end
end
