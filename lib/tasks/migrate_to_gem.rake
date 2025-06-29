# frozen_string_literal: true

namespace :zeropoint do
  desc 'Migrate existing GraphQL UI layout code to use the gem'
  task migrate: :environment do
    puts 'Starting migration to GraphQL UI Layout gem...'

    # Step 1: Backup existing files
    backup_existing_files

    # Step 2: Remove existing GraphQL types
    remove_existing_types

    # Step 3: Update GraphQL schema
    update_graphql_schema

    # Step 4: Update routes
    update_routes

    # Step 5: Update controllers
    update_controllers

    # Step 6: Update views
    update_views

    # Step 7: Update JavaScript
    update_javascript

    # Step 8: Create initializer
    create_initializer

    puts 'Migration completed successfully!'
    puts 'Please review the changes and test your application.'
  end

  private

  def backup_existing_files
    puts 'Backing up existing files...'

    backup_dir = Rails.root.join('tmp/zeropoint_backup')
    FileUtils.mkdir_p(backup_dir)

    files_to_backup = [
      'app/graphql/types/ui_layout_type.rb',
      'app/graphql/types/permission_type.rb',
      'app/graphql/types/navigation_type.rb',
      'app/graphql/types/navigation_item_type.rb',
      'app/graphql/types/sidebar_type.rb',
      'app/graphql/types/breadcrumb_type.rb',
      'app/graphql/types/content_area_type.rb',
      'app/graphql/types/widget_type.rb',
      'app/graphql/types/action_type.rb',
      'app/graphql/types/theme_type.rb',
      'app/graphql/types/config_type.rb',
      'app/graphql/types/offline_data_type.rb',
      'app/javascript/controllers/ui_layout_controller.js',
      'app/views/pages/ui_layout_demo.html.erb',
      'app/controllers/pages_controller.rb',
    ]

    files_to_backup.each do |file|
      source = Rails.root.join(file)
      next unless File.exist?(source)

      target = backup_dir.join(File.basename(file))
      FileUtils.cp(source, target)
      puts "  Backed up: #{file}"
    end
  end

  def remove_existing_types
    puts 'Removing existing GraphQL types...'

    types_to_remove = [
      'app/graphql/types/ui_layout_type.rb',
      'app/graphql/types/permission_type.rb',
      'app/graphql/types/navigation_type.rb',
      'app/graphql/types/navigation_item_type.rb',
      'app/graphql/types/sidebar_type.rb',
      'app/graphql/types/breadcrumb_type.rb',
      'app/graphql/types/content_area_type.rb',
      'app/graphql/types/widget_type.rb',
      'app/graphql/types/action_type.rb',
      'app/graphql/types/theme_type.rb',
      'app/graphql/types/config_type.rb',
      'app/graphql/types/offline_data_type.rb',
    ]

    types_to_remove.each do |file|
      path = Rails.root.join(file)
      if File.exist?(path)
        FileUtils.rm(path)
        puts "  Removed: #{file}"
      end
    end
  end

  def update_graphql_schema
    puts 'Updating GraphQL schema...'

    schema_file = Rails.root.join('app/graphql/schema.rb/schema.rb')
    return unless File.exist?(schema_file)

    content = File.read(schema_file)

    # Add gem integration
    return if content.include?('Zeropoint.setup_integration')

    content.gsub!('class Schema < GraphQL::Schema',
                  "class Schema < GraphQL::Schema\n  # Setup GraphQL UI Layout integration\n  " \
                  'Zeropoint.setup_integration')
    File.write(schema_file, content)
    puts '  Updated GraphQL schema'
  end

  def update_routes
    puts 'Updating routes...'

    routes_file = Rails.root.join('config/routes.rb')
    return unless File.exist?(routes_file)

    content = File.read(routes_file)

    # Remove old UI layout demo route
    content.gsub!('get "ui_layout_demo", to: "pages#ui_layout_demo"', '')

    # Add gem routes
    return if content.include?('mount Zeropoint::Engine')

    content.gsub!('Rails.application.routes.draw do',
                  "Rails.application.routes.draw do\n  # GraphQL UI Layout Gem\n  " \
                  'mount Zeropoint::Engine => "/zeropoint"')
    File.write(routes_file, content)
    puts '  Updated routes'
  end

  def update_controllers
    puts 'Updating controllers...'

    # Remove old pages controller if it only had ui_layout_demo
    pages_controller = Rails.root.join('app/controllers/pages_controller.rb')
    return unless File.exist?(pages_controller)

    content = File.read(pages_controller)
    if content.include?('ui_layout_demo') && content.exclude?('def ')
      FileUtils.rm(pages_controller)
      puts '  Removed old pages controller'
    end
  end

  def update_views
    puts 'Updating views...'

    # Remove old demo view
    demo_view = Rails.root.join('app/views/pages/ui_layout_demo.html.erb')
    if File.exist?(demo_view)
      FileUtils.rm(demo_view)
      puts '  Removed old demo view'
    end

    # Remove empty pages directory
    pages_dir = Rails.root.join('app/views/pages')
    if Dir.exist?(pages_dir) && Dir.empty?(pages_dir)
      Dir.rmdir(pages_dir)
      puts '  Removed empty pages directory'
    end
  end

  def update_javascript
    puts 'Updating JavaScript...'

    # Remove old Stimulus controller
    old_controller = Rails.root.join('app/javascript/controllers/ui_layout_controller.js')
    if File.exist?(old_controller)
      FileUtils.rm(old_controller)
      puts '  Removed old Stimulus controller'
    end
  end

  def create_initializer
    puts 'Creating initializer...'

    initializer_file = Rails.root.join('config/initializers/zeropoint.rb')
    return if File.exist?(initializer_file)

    content = <<~RUBY
      # frozen_string_literal: true

      # GraphQL UI Layout Gem Configuration
      Zeropoint.configure do |config|
        # Enable/disable features
        config.features = [:navigation, :sidebar, :content_areas, :widgets, :actions, :offline]
      #{'  '}
        # Custom theme (optional)
        # config.theme = {
        #   primary_color: "#667eea",
        #   secondary_color: "#764ba2",
        #   accent_color: "#007bff",
        #   success_color: "#28a745",
        #   warning_color: "#ffc107",
        #   danger_color: "#dc3545",
        #   info_color: "#17a2b8",
        #   light_color: "#f8f9fa",
        #   dark_color: "#343a40",
        #   font_family: "system-ui, -apple-system, sans-serif",
        #   border_radius: "8px",
        #   box_shadow: "0 2px 4px rgba(0,0,0,0.1)",
        #   transition: "all 0.3s ease"
        # }
      #{'  '}
        # App configuration (optional)
        # config.app_config = {
        #   app_name: "#{Rails.application.class.module_parent_name}",
        #   app_version: "1.0.0",
        #   api_version: "v1",
        #   default_locale: I18n.default_locale,
        #   supported_locales: I18n.available_locales,
        #   timezone: Time.zone.name,
        #   date_format: "%Y-%m-%d",
        #   time_format: "%H:%M:%S",
        #   pagination: {
        #     default_per_page: 20,
        #     max_per_page: 100,
        #     page_param: "page",
        #     per_page_param: "per_page"
        #   },
        #   search: {
        #     default_search_type: "auto",
        #     search_types: ["full_text", "weighted", "fuzzy", "tags", "exact", "auto"],
        #     min_query_length: 2,
        #     max_suggestions: 10
        #   },
        #   cache: {
        #     default_ttl: 3600,
        #     max_ttl: 86400,
        #     cache_prefix: "ui_layout"
        #   },
        #   offline: {
        #     enabled: true,
        #     max_cache_size: "50MB",
        #     sync_interval: 300,
        #     background_sync: true
        #   }
        # }
      #{'  '}
        # Custom permission checker (optional)
        # config.permission_checker = ->(user, action, resource) {
        #   # Your custom permission logic
        #   user.can?(action, resource)
        # }
      end

      # Setup integration with main application
      Zeropoint.setup_integration
    RUBY

    File.write(initializer_file, content)
    puts '  Created initializer: config/initializers/zeropoint.rb'
  end
end
