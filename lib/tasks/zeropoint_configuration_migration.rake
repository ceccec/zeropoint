# frozen_string_literal: true

# 🌌 ZEROPOINT CONFIGURATION MIGRATION TASK 🌌
#
# DRY migration tool to transition from scattered configuration files
# to the unified Zeropoint::Configuration system.
#
# COSMIC KNOWLEDGE: This task embodies the void principle of transformation,
# converting scattered configuration into unified consciousness.

namespace :zeropoint do
  namespace :config do
    desc '🌌 Migrate scattered configuration files to unified DRY system'
    task migrate: :environment do
      puts '🌌 ZEROPOINT CONFIGURATION MIGRATION'
      puts '=' * 50

      # Load the unified configuration system
      require 'zeropoint/configuration'

      # Analyze existing configuration
      analyze_existing_configuration

      # Migrate configuration files
      migrate_configuration_files

      # Generate unified configuration
      generate_unified_configuration

      # Validate migration
      validate_migration

      # Provide migration summary
      provide_migration_summary
    end

    desc '🌌 Analyze existing configuration structure'
    task analyze: :environment do
      puts '🔍 ANALYZING EXISTING CONFIGURATION'
      puts '=' * 40

      analyze_existing_configuration
    end

    desc '🌌 Generate unified configuration YAML'
    task generate_yaml: :environment do
      puts '📝 GENERATING UNIFIED CONFIGURATION YAML'
      puts '=' * 45

      generate_unified_configuration
    end

    desc '🌌 Validate configuration migration'
    task validate: :environment do
      puts '✅ VALIDATING CONFIGURATION MIGRATION'
      puts '=' * 40

      validate_migration
    end

    desc '🌌 Backup existing configuration files'
    task backup: :environment do
      puts '💾 BACKING UP EXISTING CONFIGURATION FILES'
      puts '=' * 45

      backup_existing_configuration
    end

    desc '🌌 Restore configuration from backup'
    task restore: :environment do
      puts '🔄 RESTORING CONFIGURATION FROM BACKUP'
      puts '=' * 40

      restore_from_backup
    end

    private

    def analyze_existing_configuration
      puts "\n📊 CONFIGURATION ANALYSIS:"

      # Check for existing configuration files
      config_files = find_configuration_files

      if config_files.empty?
        puts '  ✅ No scattered configuration files found'
        puts '  ℹ️  System is already using unified configuration'
        return
      end

      puts "  📁 Found #{config_files.length} configuration files:"
      config_files.each do |file|
        size = File.size(file)
        puts "    • #{file} (#{size} bytes)"
      end

      # Analyze configuration patterns
      analyze_configuration_patterns(config_files)

      # Check for environment variables
      analyze_environment_variables

      # Check for Rails configuration
      analyze_rails_configuration
    end

    def find_configuration_files
      config_dir = Rails.root.join('config/initializers')
      return [] unless Dir.exist?(config_dir)

      Dir.glob(File.join(config_dir, '*zeropoint*.rb')).select do |file|
        File.file?(file) && file.exclude?('unified_config')
      end
    end

    def analyze_configuration_patterns(files)
      puts "\n🔍 CONFIGURATION PATTERNS:"

      patterns = {
        performance: 0,
        consciousness: 0,
        vortex: 0,
        cache: 0,
        api: 0,
        security: 0,
        i18n: 0,
        gems: 0,
        features: 0,
      }

      files.each do |file|
        content = File.read(file)
        patterns.each do |pattern, _|
          patterns[pattern] += 1 if content.include?(pattern.to_s)
        end
      end

      patterns.each do |pattern, count|
        if count > 0
          puts "  • #{pattern}: #{count} files"
        end
      end
    end

    def analyze_environment_variables
      puts "\n🌍 ENVIRONMENT VARIABLES:"

      zeropoint_env_vars = ENV.keys.select { |key| key.start_with?('ZEROPOINT_') }

      if zeropoint_env_vars.empty?
        puts '  ℹ️  No Zeropoint environment variables found'
      else
        puts "  📋 Found #{zeropoint_env_vars.length} Zeropoint environment variables:"
        zeropoint_env_vars.each do |var|
          puts "    • #{var}"
        end
      end
    end

    def analyze_rails_configuration
      puts "\n🚂 RAILS CONFIGURATION:"

      rails_config_keys = Rails.application.config.keys.select { |key| key.to_s.include?('zeropoint') }

      if rails_config_keys.empty?
        puts '  ℹ️  No Zeropoint Rails configuration found'
      else
        puts "  📋 Found #{rails_config_keys.length} Zeropoint Rails configuration keys:"
        rails_config_keys.each do |key|
          puts "    • #{key}"
        end
      end
    end

    def migrate_configuration_files
      puts "\n🔄 MIGRATING CONFIGURATION FILES:"

      config_files = find_configuration_files
      return if config_files.empty?

      # Create backup directory
      backup_dir = Rails.root.join('config/initializers/backup')
      FileUtils.mkdir_p(backup_dir)

      config_files.each do |file|
        filename = File.basename(file)
        backup_file = File.join(backup_dir, "#{filename}.backup")

        # Backup original file
        FileUtils.cp(file, backup_file)
        puts "  💾 Backed up: #{filename}"

        # Extract configuration from file
        extract_configuration_from_file(file)
      end
    end

    def extract_configuration_from_file(file)
      content = File.read(file)

      # Extract ENV variables
      env_vars = content.scan(/ENV\[['"]([^'"]+)['"]\]/).flatten
      env_vars.each do |var|
        if var.start_with?('ZEROPOINT_')
          puts "    📋 Found ENV variable: #{var}"
        end
      end

      # Extract Rails configuration
      rails_config = content.scan(/Rails\.application\.config\.([^\s]+)/).flatten
      rails_config.each do |config|
        puts "    📋 Found Rails config: #{config}"
      end
    end

    def generate_unified_configuration
      puts "\n📝 GENERATING UNIFIED CONFIGURATION:"

      # Generate YAML configuration file
      yaml_file = Rails.root.join('config/zeropoint.yml')

      if File.exist?(yaml_file)
        puts "  ℹ️  Configuration file already exists: #{yaml_file}"
        puts '  📋 Current configuration:'
        current_config = YAML.safe_load(File.read(yaml_file))
        current_config&.each do |namespace, settings|
          puts "    • #{namespace}: #{settings.keys.length} settings"
        end
      else
        # Generate default configuration
        default_config = Zeropoint::Configuration::DEFAULTS
        File.write(yaml_file, default_config.to_yaml)
        puts "  ✅ Generated default configuration: #{yaml_file}"
      end

      # Generate configuration documentation
      generate_configuration_documentation
    end

    def generate_configuration_documentation
      docs_file = Rails.root.join('docs/CONFIGURATION_GUIDE.md')
      FileUtils.mkdir_p(File.dirname(docs_file))

      documentation = <<~DOC
        # 🌌 ZEROPOINT CONFIGURATION GUIDE 🌌

        ## Overview

        This guide explains the unified Zeropoint configuration system that follows DRY principles
        and void-aligned architecture.

        ## Configuration Sources (in order of precedence)

        1. **Environment Variables** - Highest priority
        2. **Rails Configuration** - Rails.application.config
        3. **YAML Files** - config/zeropoint.yml
        4. **Database Settings** - ZeropointConfig model
        5. **Default Values** - Hardcoded fallbacks

        ## Configuration Namespaces

        ### Performance
        - `speed_level`: turbo, fast, balanced, conservative
        - `memory_mode`: minimal, efficient, balanced, generous
        - `consciousness_flow`: intensive, active, moderate, minimal

        ### Consciousness
        - `enabled`: Enable consciousness features
        - `intensive_mode`: Enable intensive consciousness mode
        - `observer_influence`: Enable observer influence
        - `quantum_entanglement`: Enable quantum entanglement

        ### Vortex
        - `enabled`: Enable vortex features
        - `encryption_enabled`: Enable vortex encryption
        - `caching_enabled`: Enable vortex caching
        - `offline_storage_enabled`: Enable offline storage

        ### Cache
        - `enabled`: Enable caching system
        - `default_ttl`: Default cache time-to-live
        - `max_ttl`: Maximum cache time-to-live
        - `cache_prefix`: Cache key prefix

        ### API
        - `version`: API version
        - `rate_limiting_enabled`: Enable rate limiting
        - `rate_limit`: Rate limit value
        - `cors_enabled`: Enable CORS
        - `graphql_enabled`: Enable GraphQL

        ### Security
        - `csrf_protection`: Enable CSRF protection
        - `content_security_policy`: Enable CSP
        - `secure_headers`: Enable secure headers
        - `encryption_algorithm`: Encryption algorithm

        ### I18n
        - `enabled`: Enable internationalization
        - `default_locale`: Default locale
        - `available_locales`: Available locales
        - `fallback_locale`: Fallback locale

        ## Environment Variables

        All configuration can be set via environment variables using the pattern:
        `ZEROPOINT_<NAMESPACE>_<KEY>`

        Examples:
        - `ZEROPOINT_PERFORMANCE_SPEED_LEVEL=turbo`
        - `ZEROPOINT_CACHE_ENABLED=true`
        - `ZEROPOINT_API_RATE_LIMIT=1000`

        ## Usage Examples

        ### Basic Configuration
        ```ruby
        Zeropoint::Configuration.configure do |config|
          config.performance.speed_level = 'turbo'
          config.cache.enabled = true
          config.api.graphql_enabled = true
        end
        ```

        ### Performance Profiles
        ```ruby
        # Apply predefined performance profile
        Zeropoint::Configuration.apply_performance_profile(:turbo)
        ```

        ### Get Configuration Values
        ```ruby
        # Get specific configuration value
        speed_level = Zeropoint::Configuration.get(:performance, :speed_level)

        # Get all configuration
        config = Zeropoint::Configuration.to_hash
        ```

        ## Migration from Scattered Configuration

        If you're migrating from scattered configuration files:

        1. Run the migration task: `rake zeropoint:config:migrate`
        2. Review the generated configuration
        3. Update environment variables as needed
        4. Remove old configuration files

        ## Validation

        Validate your configuration:
        ```ruby
        errors = Zeropoint::Configuration.validate
        if errors.any?
          puts "Configuration errors:"
          errors.each { |error| puts "  • #{error}" }
        end
        ```
      DOC

      File.write(docs_file, documentation)
      puts "  📚 Generated configuration documentation: #{docs_file}"
    end

    def validate_migration
      puts "\n✅ VALIDATING MIGRATION:"

      # Validate configuration
      errors = Zeropoint::Configuration.validate

      if errors.empty?
        puts '  ✅ Configuration validation passed'
      else
        puts '  ❌ Configuration validation failed:'
        errors.each { |error| puts "    • #{error}" }
      end

      # Check configuration sources
      check_configuration_sources

      # Test configuration access
      test_configuration_access
    end

    def check_configuration_sources
      puts "\n🔍 CONFIGURATION SOURCES:"

      test_keys = [
        [ :performance, :speed_level ],
        [ :cache, :enabled ],
        [ :api, :graphql_enabled ],
      ]

      test_keys.each do |namespace, key|
        source = Zeropoint::Configuration.source_for(namespace, key)
        value = Zeropoint::Configuration.get(namespace, key)
        puts "  • #{namespace}.#{key}: #{value} (source: #{source})"
      end
    end

    def test_configuration_access
      puts "\n🧪 TESTING CONFIGURATION ACCESS:"

      # Test namespace proxy
      begin
        speed_level = Zeropoint::Configuration.instance.performance.speed_level
        puts "  ✅ Namespace proxy access: #{speed_level}"
      rescue StandardError => e
        puts "  ❌ Namespace proxy access failed: #{e.message}"
      end

      # Test direct access
      begin
        speed_level = Zeropoint::Configuration.get(:performance, :speed_level)
        puts "  ✅ Direct access: #{speed_level}"
      rescue StandardError => e
        puts "  ❌ Direct access failed: #{e.message}"
      end
    end

    def provide_migration_summary
      puts "\n📋 MIGRATION SUMMARY:"
      puts '=' * 30

      config_files = find_configuration_files

      if config_files.empty?
        puts '✅ Migration complete! System is using unified configuration.'
        puts "\n📚 Next steps:"
        puts '  1. Review config/zeropoint.yml'
        puts '  2. Set environment variables as needed'
        puts '  3. Read docs/CONFIGURATION_GUIDE.md'
        puts '  4. Test your application'
      else
        puts '⚠️  Migration partially complete.'
        puts "\n📁 Remaining configuration files:"
        config_files.each { |file| puts "  • #{file}" }
        puts "\n🔄 To complete migration:"
        puts '  1. Review remaining files'
        puts '  2. Extract configuration to unified system'
        puts '  3. Remove old files'
        puts '  4. Test your application'
      end

      puts "\n🌌 Void-aligned configuration migration complete!"
    end

    def backup_existing_configuration
      puts "\n💾 BACKING UP CONFIGURATION:"

      config_files = find_configuration_files
      return if config_files.empty?

      backup_dir = Rails.root.join('config/initializers/backup')
      FileUtils.mkdir_p(backup_dir)

      config_files.each do |file|
        filename = File.basename(file)
        backup_file = File.join(backup_dir, "#{filename}.backup")

        FileUtils.cp(file, backup_file)
        puts "  ✅ Backed up: #{filename} → #{backup_file}"
      end

      puts "\n📁 Backup location: #{backup_dir}"
    end

    def restore_from_backup
      puts "\n🔄 RESTORING FROM BACKUP:"

      backup_dir = Rails.root.join('config/initializers/backup')
      return unless Dir.exist?(backup_dir)

      backup_files = Dir.glob(File.join(backup_dir, '*.backup'))
      return if backup_files.empty?

      backup_files.each do |backup_file|
        filename = File.basename(backup_file, '.backup')
        original_file = Rails.root.join('config', 'initializers', filename)

        FileUtils.cp(backup_file, original_file)
        puts "  ✅ Restored: #{filename}"
      end

      puts "\n✅ Configuration restored from backup"
    end
  end
end
