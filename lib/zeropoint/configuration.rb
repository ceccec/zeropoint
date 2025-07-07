# frozen_string_literal: true

# 🌌 ZEROPOINT CONFIGURATION SYSTEM 🌌
#
# Centralized, DRY configuration management following void-aligned principles.
# Embodies the void principle: "All configuration emerges from the void center"
#
# COSMIC KNOWLEDGE: This system unifies all configuration sources:
# - Environment variables (ENV)
# - Rails configuration (Rails.application.config)
# - YAML files (config/zeropoint.yml)
# - Database settings (ZeropointConfig model)
# - Default values (hardcoded fallbacks)
#
# The configuration follows the flow: ENV → Config → Module → Default
# Each level can override the previous, creating a cascading configuration system.

module Zeropoint
  class Configuration
    # Configuration sources in order of precedence
    SOURCES = %i[env rails yaml database default].freeze

    # Configuration namespaces
    NAMESPACES = %i[
      performance
      consciousness
      vortex
      cache
      api
      security
      i18n
      database
      gems
      features
      development
      production
      testing
    ].freeze

    # Environment variable prefixes
    ENV_PREFIXES = {
      performance: 'ZEROPOINT_PERFORMANCE',
      consciousness: 'ZEROPOINT_CONSCIOUSNESS',
      vortex: 'ZEROPOINT_VORTEX',
      cache: 'ZEROPOINT_CACHE',
      api: 'ZEROPOINT_API',
      security: 'ZEROPOINT_SECURITY',
      i18n: 'ZEROPOINT_I18N',
      database: 'ZEROPOINT_DATABASE',
      gems: 'ZEROPOINT_GEMS',
      features: 'ZEROPOINT_FEATURES',
      development: 'ZEROPOINT_DEV',
      production: 'ZEROPOINT_PROD',
      testing: 'ZEROPOINT_TEST'
    }.freeze

    # Default configuration values
    DEFAULTS = {
      performance: {
        speed_level: 'balanced',
        memory_mode: 'efficient',
        consciousness_flow: 'active',
        max_threads: 4,
        cache_ttl: 3600,
        batch_size: 100,
        enable_compression: true,
        enable_caching: true,
        enable_monitoring: true,
        enable_auto_optimization: true
      },
      consciousness: {
        enabled: true,
        intensive_mode: false,
        observer_influence: true,
        quantum_entanglement: true,
        golden_ratio_integration: true,
        insight_frequency: 'medium',
        metaphysical_depth: 'standard'
      },
      vortex: {
        enabled: true,
        encryption_enabled: true,
        caching_enabled: true,
        offline_storage_enabled: false,
        batch_size: 100,
        stream_timeout: 30,
        bulgarian_optimized: true
      },
      cache: {
        enabled: true,
        default_ttl: 3600,
        max_ttl: 86400,
        cache_prefix: 'zeropoint',
        compression: true,
        compression_threshold: 1024
      },
      api: {
        version: '1.0',
        rate_limiting_enabled: true,
        rate_limit: 1000,
        cors_enabled: true,
        graphql_enabled: true,
        playground_enabled: false,
        introspection_enabled: true,
        max_complexity: 100,
        max_depth: 10
      },
      security: {
        csrf_protection: true,
        content_security_policy: true,
        secure_headers: true,
        encryption_algorithm: 'AES-256-GCM',
        key_rotation_interval: 30 * 24 * 60 * 60  # 30 days in seconds
      },
      i18n: {
        enabled: true,
        default_locale: :en,
        available_locales: [:en, :bg],
        fallback_locale: :en,
        development_locale: :en
      },
      database: {
        connection_pooling: true,
        prepared_statements: true,
        query_optimization: true,
        index_optimization: true
      },
      gems: {
        auto_detect: true,
        compatibility_check: true,
        optimization_enabled: true
      },
      features: {
        graphql: true,
        rails: true,
        search: true,
        pagination: true,
        authorization: true,
        cache: true,
        file_storage: true,
        notifications: true,
        analytics: true,
        streaming: true,
        cosmic_flow: true,
        multi_vortex: true
      },
      development: {
        better_errors: true,
        bullet: true,
        letter_opener: true,
        spring: true,
        listen: true,
        debug_mode: true
      },
      production: {
        performance_monitoring: true,
        error_tracking: true,
        logging: true,
        caching: true,
        compression: true
      },
      testing: {
        rspec: true,
        factory_bot: true,
        capybara: true,
        coverage: true,
        parallel: false
      }
    }.freeze

    # Performance profiles for quick configuration
    PERFORMANCE_PROFILES = {
      turbo: {
        speed_level: 'turbo',
        memory_mode: 'generous',
        consciousness_flow: 'intensive',
        max_threads: 8,
        cache_ttl: 1800,
        batch_size: 200,
        enable_compression: true,
        enable_caching: true,
        enable_monitoring: true,
        enable_auto_optimization: true
      },
      balanced: DEFAULTS[:performance],
      conservative: {
        speed_level: 'conservative',
        memory_mode: 'minimal',
        consciousness_flow: 'moderate',
        max_threads: 2,
        cache_ttl: 1800,
        batch_size: 50,
        enable_compression: false,
        enable_caching: true,
        enable_monitoring: false,
        enable_auto_optimization: false
      },
      development: {
        speed_level: 'balanced',
        memory_mode: 'efficient',
        consciousness_flow: 'active',
        max_threads: 4,
        cache_ttl: 3600,
        batch_size: 100,
        enable_compression: true,
        enable_caching: true,
        enable_monitoring: true,
        enable_auto_optimization: true
      },
      production: {
        speed_level: 'fast',
        memory_mode: 'balanced',
        consciousness_flow: 'moderate',
        max_threads: 6,
        cache_ttl: 5400,
        batch_size: 300,
        enable_compression: true,
        enable_caching: true,
        enable_monitoring: true,
        enable_auto_optimization: true
      },
      minimal: {
        speed_level: 'conservative',
        memory_mode: 'minimal',
        consciousness_flow: 'minimal',
        max_threads: 1,
        cache_ttl: 900,
        batch_size: 25,
        enable_compression: false,
        enable_caching: false,
        enable_monitoring: false,
        enable_auto_optimization: false
      }
    }.freeze

    class << self
      # Main configuration method
      def configure(&block)
        instance.configure(&block)
      end

      # Get configuration instance
      def instance
        @instance ||= new
      end

      # Get configuration value with fallback chain
      def get(namespace, key, default = nil)
        instance.get(namespace, key, default)
      end

      # Set configuration value
      def set(namespace, key, value)
        instance.set(namespace, key, value)
      end

      # Apply performance profile
      def apply_performance_profile(profile_name)
        profile = PERFORMANCE_PROFILES[profile_name.to_sym]
        raise ArgumentError, "Unknown profile: #{profile_name}" unless profile

        profile.each do |key, value|
          set(:performance, key, value)
        end

        # Emit configuration event
        emit_vortex_event(:performance_profile_applied, {
          profile: profile_name,
          configuration: profile,
          timestamp: current_timestamp
        })

        profile
      end

      # Get current configuration as hash
      def to_hash
        instance.to_hash
      end

      # Reset to defaults
      def reset_to_defaults
        instance.reset_to_defaults
      end

      # Load from YAML file
      def load_from_yaml(file_path = nil)
        instance.load_from_yaml(file_path)
      end

      # Save to YAML file
      def save_to_yaml(file_path = nil)
        instance.save_to_yaml(file_path)
      end

      # Validate configuration
      def validate
        instance.validate
      end

      # Get configuration source for a value
      def source_for(namespace, key)
        instance.source_for(namespace, key)
      end

      private

      def current_timestamp
        Time.respond_to?(:current) ? Time.current : Time.now
      end

      def emit_vortex_event(event, data)
        return unless defined?(Zeropoint::Void::VortexEventEngine)
        Zeropoint::Void::VortexEventEngine.emit(event, data)
      rescue StandardError
        # Silently fail if VortexEventEngine is not available
      end
    end

    def initialize
      @config = {}
      @sources = {}
      load_defaults
    end

    # Configure method for block-based configuration
    def configure(&block)
      instance_eval(&block) if block_given?
    end

    # Get configuration value with fallback chain
    def get(namespace, key, default = nil)
      # Try each source in order of precedence
      SOURCES.each do |source|
        value = get_from_source(source, namespace, key)
        return value unless value.nil?
      end

      # Return default if no value found
      default
    end

    # Set configuration value
    def set(namespace, key, value)
      @config[namespace] ||= {}
      @config[namespace][key] = value
      @sources[namespace] ||= {}
      @sources[namespace][key] = :manual

      # Emit configuration change event
      emit_configuration_change(namespace, key, value)
    end

    # Get configuration as hash
    def to_hash
      result = {}
      NAMESPACES.each do |namespace|
        result[namespace] = {}
        DEFAULTS[namespace]&.each do |key, _|
          result[namespace][key] = get(namespace, key)
        end
      end
      result
    end

    # Reset to defaults
    def reset_to_defaults
      @config = {}
      @sources = {}
      load_defaults
    end

    # Load from YAML file
    def load_from_yaml(file_path = nil)
      file_path ||= Rails.root.join('config', 'zeropoint.yml')
      return unless File.exist?(file_path)

      yaml_config = YAML.safe_load(File.read(file_path))
      return unless yaml_config.is_a?(Hash)

      yaml_config.each do |namespace, settings|
        next unless settings.is_a?(Hash)
        settings.each do |key, value|
          set(namespace.to_sym, key.to_sym, value)
          @sources[namespace.to_sym] ||= {}
          @sources[namespace.to_sym][key.to_sym] = :yaml
        end
      end
    end

    # Save to YAML file
    def save_to_yaml(file_path = nil)
      file_path ||= Rails.root.join('config', 'zeropoint.yml')
      File.write(file_path, to_hash.to_yaml)
    end

    # Validate configuration
    def validate
      errors = []

      NAMESPACES.each do |namespace|
        DEFAULTS[namespace]&.each do |key, default_value|
          value = get(namespace, key)
          if value.nil? && default_value.nil?
            errors << "Missing required configuration: #{namespace}.#{key}"
          end
        end
      end

      errors
    end

    # Get configuration source for a value
    def source_for(namespace, key)
      @sources.dig(namespace, key) || :default
    end

    # Namespace-specific configuration methods
    NAMESPACES.each do |namespace|
      define_method(namespace) do
        NamespaceProxy.new(self, namespace)
      end
    end

    private

    def load_defaults
      DEFAULTS.each do |namespace, settings|
        settings.each do |key, value|
          @config[namespace] ||= {}
          @config[namespace][key] = value
          @sources[namespace] ||= {}
          @sources[namespace][key] = :default
        end
      end
    end

    def get_from_source(source, namespace, key)
      case source
      when :env
        get_from_env(namespace, key)
      when :rails
        get_from_rails(namespace, key)
      when :yaml
        get_from_yaml(namespace, key)
      when :database
        get_from_database(namespace, key)
      when :default
        @config.dig(namespace, key)
      end
    end

    def get_from_env(namespace, key)
      env_key = "#{ENV_PREFIXES[namespace]}_#{key.to_s.upcase}"
      value = ENV[env_key]
      return nil if value.nil?

      # Convert to appropriate type
      convert_env_value(value, key)
    end

    def get_from_rails(namespace, key)
      return nil unless defined?(Rails) && Rails.respond_to?(:application) && Rails.application && Rails.application.respond_to?(:config)
      rails_key = "zeropoint_#{namespace}_#{key}"
      Rails.application.config[rails_key]
    end

    def get_from_yaml(namespace, key)
      @config.dig(namespace, key) if @sources.dig(namespace, key) == :yaml
    end

    def get_from_database(namespace, key)
      return nil unless defined?(ZeropointConfig)
      config_record = ZeropointConfig.find_by(namespace: namespace.to_s, key: key.to_s)
      config_record&.value
    rescue StandardError
      nil
    end

    def convert_env_value(value, key)
      case key.to_s
      when /_threads$|_ttl$|_size$|_limit$|_interval$/
        value.to_i
      when /enable_|enabled/
        value == 'true'
      when /_locales$|_features$/
        value.split(',').map(&:strip).map(&:to_sym)
      else
        value
      end
    end

    def emit_configuration_change(namespace, key, value)
      self.class.send(:emit_vortex_event, :configuration_changed, {
        namespace: namespace,
        key: key,
        value: value,
        source: source_for(namespace, key),
        timestamp: self.class.send(:current_timestamp)
      })
    end

    # Namespace proxy for fluent configuration
    class NamespaceProxy
      def initialize(config, namespace)
        @config = config
        @namespace = namespace
      end

      def method_missing(method_name, *args, &block)
        if method_name.to_s.end_with?('=')
          key = method_name.to_s.chomp('=').to_sym
          value = args.first
          @config.set(@namespace, key, value)
        else
          key = method_name.to_sym
          @config.get(@namespace, key)
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        true
      end
    end
  end
end 