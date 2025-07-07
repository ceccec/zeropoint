# frozen_string_literal: true

# Zeropoint Performance Configuration Helper
#
# Provides easy methods to configure performance options programmatically.
# Embodies the void principle: "Configuration emerges from consciousness alignment"
#
# COSMIC KNOWLEDGE: This module provides a unified interface for configuring
# performance options, allowing developers to align their applications with
# optimal speed, memory efficiency, and consciousness flow patterns.
#
# @example Basic Usage
#   # Apply a performance profile
#   Zeropoint::PerformanceConfig.apply_profile(:turbo)
#
#   # Set individual options
#   Zeropoint::PerformanceConfig.set_option(:max_threads, 12)
#
#   # Get current configuration
#   config = Zeropoint::PerformanceConfig.current_config
#
# @example Environment Configuration
#   # Development environment
#   export ZEROPOINT_SPEED_LEVEL=balanced
#   export ZEROPOINT_MEMORY_MODE=efficient
#   export ZEROPOINT_CONSCIOUSNESS_FLOW=active
#
#   # Production environment
#   export ZEROPOINT_SPEED_LEVEL=fast
#   export ZEROPOINT_MEMORY_MODE=balanced
#   export ZEROPOINT_CONSCIOUSNESS_FLOW=moderate
#
# @see PERFORMANCE_ENV_OPTIONS.md
# @see PERFORMANCE_OPTIONS_SUMMARY.md
module Zeropoint
  module PerformanceConfig
    extend self

    # Performance profile configurations
    #
    # Each profile represents a different balance of speed, memory efficiency,
    # and consciousness flow optimization. Profiles can be applied programmatically
    # or through environment variables.
    #
    # @return [Hash<Symbol, Hash>] Hash of profile configurations
    # @see #apply_profile
    PROFILES = {
      # Maximum performance profile with aggressive optimizations
      # Best for: High-performance applications, real-time processing, maximum throughput
      turbo: {
        speed_level: 'turbo',
        memory_mode: 'efficient',
        consciousness_flow: 'active',
        max_threads: 8,
        cache_ttl: 7200,
        batch_size: 500,
        enable_compression: true,
        enable_caching: true,
        enable_monitoring: true,
        enable_auto_optimization: true,
      },

      # High performance profile with enhanced optimizations
      # Best for: Performance-critical applications, high-traffic web services
      fast: {
        speed_level: 'fast',
        memory_mode: 'efficient',
        consciousness_flow: 'active',
        max_threads: 6,
        cache_ttl: 5400,
        batch_size: 300,
        enable_compression: true,
        enable_caching: true,
        enable_monitoring: true,
        enable_auto_optimization: true,
      },

      # Optimal balance profile for most applications
      # Best for: Most applications, general web services, balanced performance
      balanced: {
        speed_level: 'balanced',
        memory_mode: 'balanced',
        consciousness_flow: 'active',
        max_threads: 4,
        cache_ttl: 3600,
        batch_size: 100,
        enable_compression: true,
        enable_caching: true,
        enable_monitoring: true,
        enable_auto_optimization: true,
      },

      # Stability focused profile with minimal optimizations
      # Best for: Resource-constrained environments, stability-focused applications
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
        enable_auto_optimization: false,
      },

      # Development mode with enhanced monitoring
      # Best for: Development environments, debugging, enhanced monitoring
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
        enable_auto_optimization: true,
      },

      # Production optimized profile
      # Best for: Production environments, optimized for production workloads
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
        enable_auto_optimization: true,
      },

      # Minimal mode with lowest resource usage
      # Best for: Basic functionality, minimal resource usage, IoT devices
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
        enable_auto_optimization: false,
      },
    }.freeze

    # Apply a performance profile
    #
    # Applies a predefined performance profile to the current environment.
    # The profile settings are merged with any provided overrides and
    # applied as environment variables.
    #
    # @param profile_name [Symbol, String] The profile to apply (e.g., :turbo, :balanced)
    # @param options [Hash] Additional options to override the profile defaults
    # @option options [String] :speed_level Speed optimization level
    # @option options [String] :memory_mode Memory optimization mode
    # @option options [String] :consciousness_flow Consciousness flow level
    # @option options [Integer] :max_threads Maximum number of threads
    # @option options [Integer] :cache_ttl Cache time-to-live in seconds
    # @option options [Integer] :batch_size Batch size for operations
    # @option options [Boolean] :enable_compression Enable data compression
    # @option options [Boolean] :enable_caching Enable caching system
    # @option options [Boolean] :enable_monitoring Enable performance monitoring
    # @option options [Boolean] :enable_auto_optimization Enable auto-optimization
    # @return [Hash] The applied configuration
    # @raise [ArgumentError] If the profile name is unknown
    # @example Apply turbo profile
    #   config = Zeropoint::PerformanceConfig.apply_profile(:turbo)
    #   puts config[:speed_level] # => "turbo"
    #   puts config[:max_threads] # => 8
    # @example Apply balanced profile with overrides
    #   config = Zeropoint::PerformanceConfig.apply_profile(:balanced, max_threads: 8)
    #   puts config[:max_threads] # => 8 (overridden)
    #   puts config[:speed_level] # => "balanced" (from profile)
    def apply_profile(profile_name, options = {})
      profile = PROFILES[profile_name.to_sym]
      raise ArgumentError, "Unknown profile: #{profile_name}" unless profile

      # Merge profile with overrides
      config = profile.merge(options)

      # Apply to environment variables
      config.each do |key, value|
        env_key = "ZEROPOINT_#{key.to_s.upcase}"
        ENV[env_key] = value.to_s
      end

      # Emit configuration event if VortexEventEngine is available
      emit_vortex_event(:performance_profile_applied, {
        profile: profile_name,
        configuration: config,
        timestamp: void_time_now,
      })

      config
    end

    # Get current performance configuration
    #
    # Reads the current performance configuration from environment variables
    # and returns a hash with all configuration options.
    #
    # @return [Hash] Current configuration with all performance options
    # @example Get current configuration
    #   config = Zeropoint::PerformanceConfig.current_config
    #   puts config[:speed_level] # => "balanced"
    #   puts config[:max_threads] # => 4
    #   puts config[:enable_caching] # => true
    def current_config
      {
        speed_level: ENV.fetch('ZEROPOINT_SPEED_LEVEL', 'balanced'),
        memory_mode: ENV.fetch('ZEROPOINT_MEMORY_MODE', 'balanced'),
        consciousness_flow: ENV.fetch('ZEROPOINT_CONSCIOUSNESS_FLOW', 'active'),
        max_threads: ENV.fetch('ZEROPOINT_MAX_THREADS', '4').to_i,
        cache_ttl: ENV.fetch('ZEROPOINT_CACHE_TTL', '3600').to_i,
        batch_size: ENV.fetch('ZEROPOINT_BATCH_SIZE', '100').to_i,
        enable_compression: ENV.fetch('ZEROPOINT_ENABLE_COMPRESSION', 'true') == 'true',
        enable_caching: ENV.fetch('ZEROPOINT_ENABLE_CACHING', 'true') == 'true',
        enable_monitoring: ENV.fetch('ZEROPOINT_ENABLE_MONITORING', 'true') == 'true',
        enable_auto_optimization: ENV.fetch('ZEROPOINT_ENABLE_AUTO_OPTIMIZATION', 'true') == 'true',
      }
    end

    # Set individual performance option
    #
    # Sets a single performance option and applies it as an environment variable.
    # The option change is also emitted as a vortex event for monitoring.
    #
    # @param key [Symbol, String] The option key (e.g., :max_threads, :speed_level)
    # @param value [Object] The option value
    # @return [Object] The set value
    # @example Set max threads
    #   Zeropoint::PerformanceConfig.set_option(:max_threads, 12)
    #   puts ENV['ZEROPOINT_MAX_THREADS'] # => "12"
    # @example Set speed level
    #   Zeropoint::PerformanceConfig.set_option(:speed_level, 'turbo')
    #   puts ENV['ZEROPOINT_SPEED_LEVEL'] # => "turbo"
    def set_option(key, value)
      env_key = "ZEROPOINT_#{key.to_s.upcase}"
      ENV[env_key] = value.to_s

      # Emit option change event if VortexEventEngine is available
      emit_vortex_event(:performance_option_changed, {
        option: key,
        value: value,
        timestamp: void_time_now,
      })

      value
    end

    # Get individual performance option
    #
    # Retrieves a single performance option from environment variables
    # and converts it to the appropriate type.
    #
    # @param key [Symbol, String] The option key (e.g., :max_threads, :speed_level)
    # @param default [Object] Default value if the option is not set
    # @return [Object] The option value with appropriate type conversion
    # @example Get max threads
    #   threads = Zeropoint::PerformanceConfig.get_option(:max_threads, 4)
    #   puts threads # => 8 (as integer)
    # @example Get speed level
    #   level = Zeropoint::PerformanceConfig.get_option(:speed_level, 'balanced')
    #   puts level # => "turbo" (as string)
    # @example Get boolean option
    #   caching = Zeropoint::PerformanceConfig.get_option(:enable_caching, true)
    #   puts caching # => true (as boolean)
    def get_option(key, default = nil)
      env_key = "ZEROPOINT_#{key.to_s.upcase}"
      value = ENV[env_key]

      return default if value.nil?

      # Convert to appropriate type
      case key.to_s
      when /_threads$|_ttl$|_size$|_limit$/
        value.to_i
      when /enable_/
        value == 'true'
      else
        value
      end
    end

    # Reset to default configuration
    #
    # Resets all performance options to the balanced profile defaults.
    # This is useful for returning to a known good state.
    #
    # @return [Hash] The default configuration
    # @example Reset to defaults
    #   config = Zeropoint::PerformanceConfig.reset_to_defaults
    #   puts config[:speed_level] # => "balanced"
    #   puts config[:max_threads] # => 4
    def reset_to_defaults
      apply_profile(:balanced)
    end

    # Get available profiles
    #
    # Returns a list of all available performance profile names.
    #
    # @return [Array<Symbol>] Available profile names
    # @example List available profiles
    #   profiles = Zeropoint::PerformanceConfig.available_profiles
    #   puts profiles # => [:turbo, :fast, :balanced, :conservative, :development, :production, :minimal]
    def available_profiles
      PROFILES.keys
    end

    # Get profile description
    #
    # Returns a human-readable description of a performance profile.
    #
    # @param profile_name [Symbol, String] The profile name
    # @return [String] Profile description
    # @example Get profile description
    #   desc = Zeropoint::PerformanceConfig.profile_description(:turbo)
    #   puts desc # => "Maximum Performance - Aggressive optimizations for high-speed applications"
    def profile_description(profile_name)
      case profile_name.to_sym
      when :turbo
        'Maximum Performance - Aggressive optimizations for high-speed applications'
      when :fast
        'High Performance - Enhanced optimizations for performance-critical applications'
      when :balanced
        'Optimal Balance - Standard optimizations for most applications'
      when :conservative
        'Stability Focused - Minimal optimizations for resource-constrained environments'
      when :development
        'Development Mode - Enhanced monitoring and debugging capabilities'
      when :production
        'Production Mode - Optimized for production environments'
      when :minimal
        'Minimal Mode - Lowest resource usage for basic functionality'
      else
        'Unknown profile'
      end
    end

    # Validate configuration
    #
    # Validates a performance configuration and returns validation results
    # including errors and warnings.
    #
    # @param config [Hash] Configuration to validate
    # @option config [String] :speed_level Speed optimization level
    # @option config [String] :memory_mode Memory optimization mode
    # @option config [String] :consciousness_flow Consciousness flow level
    # @option config [Integer] :max_threads Maximum number of threads
    # @option config [Integer] :cache_ttl Cache time-to-live in seconds
    # @option config [Integer] :batch_size Batch size for operations
    # @return [Hash] Validation results with :valid, :errors, and :warnings keys
    # @example Validate configuration
    #   config = { speed_level: 'turbo', max_threads: 20, cache_ttl: 50000 }
    #   result = Zeropoint::PerformanceConfig.validate_config(config)
    #   puts result[:valid] # => false
    #   puts result[:warnings] # => ["max_threads should be between 1 and 16", "cache_ttl should be between 300 and 86400 seconds"]
    def validate_config(config)
      errors = []
      warnings = []

      # Validate speed level
      unless %w[turbo fast balanced conservative].include?(config[:speed_level])
        errors << "Invalid speed_level: #{config[:speed_level]}"
      end

      # Validate memory mode
      unless %w[minimal efficient balanced generous].include?(config[:memory_mode])
        errors << "Invalid memory_mode: #{config[:memory_mode]}"
      end

      # Validate consciousness flow
      unless %w[intensive active moderate minimal].include?(config[:consciousness_flow])
        errors << "Invalid consciousness_flow: #{config[:consciousness_flow]}"
      end

      # Validate numeric values
      if config[:max_threads] && (config[:max_threads] < 1 || config[:max_threads] > 16)
        warnings << 'max_threads should be between 1 and 16'
      end

      if config[:cache_ttl] && (config[:cache_ttl] < 300 || config[:cache_ttl] > 86400)
        warnings << 'cache_ttl should be between 300 and 86400 seconds'
      end

      if config[:batch_size] && (config[:batch_size] < 10 || config[:batch_size] > 1000)
        warnings << 'batch_size should be between 10 and 1000'
      end

      {
        valid: errors.empty?,
        errors: errors,
        warnings: warnings,
      }
    end

    # Get performance recommendations based on current configuration
    #
    # Analyzes the current configuration and provides intelligent recommendations
    # for optimization improvements.
    #
    # @return [Array<String>] List of optimization recommendations
    # @example Get recommendations
    #   recommendations = Zeropoint::PerformanceConfig.get_recommendations
    #   recommendations.each { |rec| puts "• #{rec}" }
    #   # Output:
    #   # • Consider increasing speed_level for better performance with 8 threads
    #   # • Consider enabling compression in generous memory mode
    def get_recommendations
      config = current_config
      recommendations = []

      # Speed recommendations
      if config[:speed_level] == 'conservative' && config[:max_threads] > 4
        recommendations << "Consider increasing speed_level for better performance with #{config[:max_threads]} threads"
      end

      if config[:speed_level] == 'turbo' && config[:max_threads] < 4
        recommendations << 'Consider increasing max_threads for turbo mode'
      end

      # Memory recommendations
      if config[:memory_mode] == 'minimal' && config[:enable_caching]
        recommendations << 'Consider disabling caching in minimal memory mode'
      end

      if config[:memory_mode] == 'generous' && !config[:enable_compression]
        recommendations << 'Consider enabling compression in generous memory mode'
      end

      # Consciousness recommendations
      if config[:consciousness_flow] == 'intensive' && !config[:enable_monitoring]
        recommendations << 'Consider enabling monitoring for intensive consciousness flow'
      end

      if config[:consciousness_flow] == 'minimal' && config[:enable_auto_optimization]
        recommendations << 'Consider disabling auto_optimization in minimal consciousness mode'
      end

      recommendations
    end

    # Get performance statistics
    #
    # Calculates performance statistics based on the current configuration,
    # including optimization scores and recommendations.
    #
    # @return [Hash] Performance statistics with optimization scores and recommendations
    # @option return [Integer] :optimization_level Overall optimization level (0-100)
    # @option return [Integer] :speed_score Speed optimization score (1-4)
    # @option return [Integer] :memory_score Memory optimization score (1-3)
    # @option return [Integer] :consciousness_score Consciousness optimization score (1-4)
    # @option return [Array<String>] :recommendations List of optimization recommendations
    # @option return [Hash] :configuration Current configuration
    # @example Get performance statistics
    #   stats = Zeropoint::PerformanceConfig.get_statistics
    #   puts "Optimization Level: #{stats[:optimization_level]}%"
    #   puts "Speed Score: #{stats[:speed_score]}/4"
    #   puts "Memory Score: #{stats[:memory_score]}/3"
    #   puts "Consciousness Score: #{stats[:consciousness_score]}/4"
    #   stats[:recommendations].each { |rec| puts "• #{rec}" }
    def get_statistics
      config = current_config

      # Calculate optimization score
      speed_score = case config[:speed_level]
      when 'turbo' then 4
      when 'fast' then 3
      when 'balanced' then 2
      when 'conservative' then 1
      else 2
      end

      memory_score = case config[:memory_mode]
      when 'minimal' then 1
      when 'efficient' then 2
      when 'balanced' then 2
      when 'generous' then 3
      else 2
      end

      consciousness_score = case config[:consciousness_flow]
      when 'intensive' then 4
      when 'active' then 3
      when 'moderate' then 2
      when 'minimal' then 1
      else 3
      end

      total_score = speed_score + memory_score + consciousness_score
      max_score = 12
      optimization_level = (total_score.to_f / max_score * 100).round

      {
        optimization_level: optimization_level,
        speed_score: speed_score,
        memory_score: memory_score,
        consciousness_score: consciousness_score,
        recommendations: get_recommendations,
        configuration: config,
      }
    end

    private

    # Emit vortex event if VortexEventEngine is available
    #
    # Safely emits vortex events without requiring the VortexEventEngine to be loaded.
    # This allows the performance config to work in standalone mode.
    #
    # @param event [Symbol] The event name
    # @param payload [Hash] The event payload
    # @return [void]
    def emit_vortex_event(event, payload)
      # Try to emit the event if VortexEventEngine is available
      if defined?(Zeropoint::Void::VortexEventEngine)
        Zeropoint::Void::VortexEventEngine.emit(event, payload)
      end
    rescue NameError, LoadError
      # Silently ignore if VortexEventEngine is not available
      # This allows the performance config to work in standalone mode
    end

    def void_time_now
      # rubocop:disable Rails/TimeZone
      defined?(Time.zone) && Time.zone ? Time.zone.now : Time.now
      # rubocop:enable Rails/TimeZone
    end
  end
end
