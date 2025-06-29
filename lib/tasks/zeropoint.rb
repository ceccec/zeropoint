# frozen_string_literal: true

namespace :zeropoint do
  desc 'Install Zeropoint framework with full backend and frontend integration'
  task :install, [ :skip_backend, :skip_frontend, :skip_database, :skip_assets ] => :environment do |_t, args|
    Rails.logger.debug 'Installing Zeropoint Framework...'

    # Convert args to options hash
    options = {
      skip_backend: args[:skip_backend] == 'true',
      skip_frontend: args[:skip_frontend] == 'true',
      skip_database: args[:skip_database] == 'true',
      skip_assets: args[:skip_assets] == 'true',
    }

    # Run the install generator
    Rails::Generators.invoke('zeropoint:install', [], options)
  end

  desc 'Install Zeropoint backend components (models, controllers, services, GraphQL, API)'
  task :install_backend, [ :skip_models, :skip_controllers, :skip_services, :skip_graphql, :skip_api ] => :environment do |_t, args|
    Rails.logger.debug 'Installing Zeropoint Backend Components...'

    # Convert args to options hash
    options = {
      skip_models: args[:skip_models] == 'true',
      skip_controllers: args[:skip_controllers] == 'true',
      skip_services: args[:skip_services] == 'true',
      skip_graphql: args[:skip_graphql] == 'true',
      skip_api: args[:skip_api] == 'true',
    }

    # Run the backend generator
    Rails::Generators.invoke('zeropoint:backend', [], options)
  end

  desc 'Install Zeropoint frontend components (JavaScript, CSS, Stimulus, TypeScript, Components)'
  task :install_frontend, [ :skip_javascript, :skip_stylesheets, :skip_stimulus, :skip_typescript, :skip_components ] => :environment do |_t, args|
    Rails.logger.debug 'Installing Zeropoint Frontend Components...'

    # Convert args to options hash
    options = {
      skip_javascript: args[:skip_javascript] == 'true',
      skip_stylesheets: args[:skip_stylesheets] == 'true',
      skip_stimulus: args[:skip_stimulus] == 'true',
      skip_typescript: args[:skip_typescript] == 'true',
      skip_components: args[:skip_components] == 'true',
    }

    # Run the frontend generator
    Rails::Generators.invoke('zeropoint:frontend', [], options)
  end

  desc 'Generate Zeropoint component'
  task :generate_component, [ :name ] => :environment do |_t, args|
    unless args[:name]
      Rails.logger.debug 'Error: Component name is required'
      Rails.logger.debug 'Usage: rails zeropoint:generate_component[ComponentName]'
      abort
    end

    Rails.logger.debug "Generating Zeropoint Component: #{args[:name]}"
    Rails::Generators.invoke('zeropoint:component', [ args[:name] ])
  end

  desc 'Generate Zeropoint service'
  task :generate_service, [ :name ] => :environment do |_t, args|
    unless args[:name]
      Rails.logger.debug 'Error: Service name is required'
      Rails.logger.debug 'Usage: rails zeropoint:generate_service[ServiceName]'
      abort
    end

    Rails.logger.debug "Generating Zeropoint Service: #{args[:name]}"
    Rails::Generators.invoke('zeropoint:service', [ args[:name] ])
  end

  desc 'Generate Zeropoint API'
  task :generate_api, [ :name ] => :environment do |_t, args|
    unless args[:name]
      Rails.logger.debug 'Error: API name is required'
      Rails.logger.debug 'Usage: rails zeropoint:generate_api[ApiName]'
      abort
    end

    Rails.logger.debug "Generating Zeropoint API: #{args[:name]}"
    Rails::Generators.invoke('zeropoint:api', [ args[:name] ])
  end

  desc 'Check Zeropoint installation status'
  task status: :environment do
    Rails.logger.debug 'Checking Zeropoint Installation Status...'
    Rails.logger.debug '=' * 50

    # Check for key files and directories
    files_to_check = [
      'config/initializers/zeropoint.rb',
      'config/zeropoint.yml',
      'config/routes/zeropoint.rb',
      'app/controllers/zeropoint_controller.rb',
      'app/models/zeropoint_config.rb',
      'app/services/zeropoint_service.rb',
      'app/javascript/zeropoint.js',
      'app/assets/stylesheets/zeropoint.scss',
    ]

    files_to_check.each do |file|
      if File.exist?(file)
        Rails.logger.debug "✓ #{file}"
      else
        Rails.logger.debug "✗ #{file} (missing)"
      end
    end

    # Check for routes
    routes_file = 'config/routes.rb'
    if File.exist?(routes_file)
      content = File.read(routes_file)
      if content.include?('zeropoint')
        Rails.logger.debug '✓ Zeropoint routes configured'
      else
        Rails.logger.debug '✗ Zeropoint routes not configured'
      end
    end

    # Check for database tables
    begin
      if defined?(ZeropointConfig) && ZeropointConfig.table_exists?
        Rails.logger.debug '✓ Zeropoint database tables exist'
      else
        Rails.logger.debug '✗ Zeropoint database tables missing (run: rails db:migrate)'
      end
    rescue StandardError => e
      Rails.logger.debug "✗ Database check failed: #{e.message}"
    end

    Rails.logger.debug '=' * 50
    Rails.logger.debug 'Installation commands:'
    Rails.logger.debug '  rails zeropoint:install              # Full installation'
    Rails.logger.debug '  rails zeropoint:install_backend      # Backend only'
    Rails.logger.debug '  rails zeropoint:install_frontend     # Frontend only'
  end

  desc 'Uninstall Zeropoint framework'
  task uninstall: :environment do
    Rails.logger.debug 'Uninstalling Zeropoint Framework...'
    Rails.logger.debug 'This will remove all Zeropoint files and configurations.'
    Rails.logger.debug 'Are you sure? (y/N): '

    response = STDIN.gets.chomp.downcase
    if response == 'y' || response == 'yes'
      # Remove files
      files_to_remove = [
        'config/initializers/zeropoint.rb',
        'config/zeropoint.yml',
        'config/routes/zeropoint.rb',
        'app/controllers/zeropoint_controller.rb',
        'app/controllers/api/v1/zeropoint_controller.rb',
        'app/models/zeropoint_config.rb',
        'app/services/zeropoint_service.rb',
        'app/javascript/zeropoint.js',
        'app/assets/stylesheets/zeropoint.scss',
      ]

      files_to_remove.each do |file|
        if File.exist?(file)
          File.delete(file)
          Rails.logger.debug "✓ Removed #{file}"
        end
      end

      # Remove routes from main routes file
      routes_file = 'config/routes.rb'
      if File.exist?(routes_file)
        content = File.read(routes_file)
        new_content = content.gsub(/# Zeropoint Framework Routes.*?draw 'routes\/zeropoint'\n\n/m, '')
        File.write(routes_file, new_content)
        Rails.logger.debug '✓ Removed Zeropoint routes'
      end

      Rails.logger.debug '✓ Zeropoint Framework uninstalled'
      Rails.logger.debug 'Note: You may need to manually remove database tables and other customizations'
    else
      Rails.logger.debug 'Uninstallation cancelled'
    end
  end

  desc 'Update Zeropoint framework'
  task update: :environment do
    Rails.logger.debug 'Updating Zeropoint Framework...'

    # Check if Zeropoint is installed
    unless File.exist?('config/initializers/zeropoint.rb')
      Rails.logger.debug "Error: Zeropoint is not installed. Run 'rails zeropoint:install' first."
      abort
    end

    # Backup current configuration
    if File.exist?('config/zeropoint.yml')
      backup_file = "config/zeropoint.yml.backup.#{Time.now.to_i}"
      File.copy('config/zeropoint.yml', backup_file)
      Rails.logger.debug "✓ Backed up configuration to #{backup_file}"
    end

    # Run update generator (same as install but with update flag)
    Rails::Generators.invoke('zeropoint:install', [], { update: true })

    Rails.logger.debug '✓ Zeropoint Framework updated'
    Rails.logger.debug 'Note: Check the backup file if you need to restore any custom configurations'
  end
end
