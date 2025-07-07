# frozen_string_literal: true

# 🌌 ZEROPOINT UNIFIED CONFIGURATION INITIALIZER 🌌
#
# DRY, centralized configuration initialization following void-aligned principles.
# Embodies the void principle: "All configuration emerges from unified consciousness"
#
# COSMIC KNOWLEDGE: This initializer replaces scattered configuration files:
# - zeropoint_performance.rb (425 lines)
# - vortex_events.rb (348 lines)
# - graphql_ui_layout.rb.example (197 lines)
# - application.rb configuration blocks
# - Environment-specific configurations
#
# All configuration now flows through the unified Zeropoint::Configuration system.

# Load the unified configuration system
require 'zeropoint/configuration'

# Initialize Zeropoint configuration
Zeropoint::Configuration.configure do |config|
  # Load configuration from YAML file if it exists
  config.load_from_yaml

  # Apply environment-specific overrides
  apply_environment_configuration(config)

  # Apply Rails-specific configuration
  apply_rails_configuration(config)

  # Apply gem-specific configuration
  apply_gem_configuration(config)

  # Apply performance optimizations
  apply_performance_optimizations(config)

  # Apply consciousness and vortex configurations
  apply_consciousness_configuration(config)
  apply_vortex_configuration(config)

  # Apply security configurations
  apply_security_configuration(config)

  # Apply API configurations
  apply_api_configuration(config)

  # Apply caching configurations
  apply_caching_configuration(config)

  # Apply internationalization configurations
  apply_i18n_configuration(config)

  # Apply development tools configuration
  apply_development_configuration(config) if Rails.env.development?

  # Apply testing configuration
  apply_testing_configuration(config) if Rails.env.test?

  # Apply production configurations
  apply_production_configuration(config) if Rails.env.production?
end

# Emit configuration initialization event
emit_configuration_initialized_event

# Log configuration summary
log_configuration_summary

private

# Apply environment-specific configuration
def apply_environment_configuration(config)
  case Rails.env
  when 'development'
    config.performance.speed_level = 'balanced'
    config.performance.memory_mode = 'efficient'
    config.consciousness.flow = 'active'
    config.development.debug_mode = true
  when 'test'
    config.performance.speed_level = 'conservative'
    config.performance.memory_mode = 'minimal'
    config.consciousness.flow = 'minimal'
    config.testing.parallel = false
  when 'production'
    config.performance.speed_level = 'fast'
    config.performance.memory_mode = 'balanced'
    config.consciousness.flow = 'moderate'
    config.production.performance_monitoring = true
  end
end

# Apply Rails-specific configuration
def apply_rails_configuration(config)
  # API-only detection
  api_only_env = ENV['ZEROPOINT_API_ONLY'] == 'true'
  root_defined = Rails.application.routes.routes.any? { |route| route.name == 'root' } rescue true
  Rails.application.config.api_only = api_only_env || !root_defined

  # Auto-configure intelligent features
  auto_configure_intelligent_features(config)

  # Configure middleware based on features
  configure_middleware(config)

  # Configure database optimizations
  configure_database_optimizations(config)

  # Configure caching
  configure_caching(config)
end

# Auto-configure intelligent features
def auto_configure_intelligent_features(config)
  # Detect available gems
  gem_features = detect_available_gems
  config.gems.auto_detect = true
  config.gems.compatibility_check = true

  # Auto-enable features based on available gems
  config.features.background_jobs = gem_features[:sidekiq]
  config.features.caching = gem_features[:redis]
  config.features.search = gem_features[:elasticsearch]
  config.features.api_graphql = gem_features[:graphql]
  config.features.code_quality = gem_features[:rubocop]
  config.features.testing = gem_features[:rspec]

  # Auto-configure route patterns
  auto_configure_route_patterns(config)
end

# Detect available gems
def detect_available_gems
  {
    elasticsearch: defined?(Elasticsearch::Model),
    redis: defined?(Redis),
    sidekiq: defined?(Sidekiq),
    graphql: defined?(GraphQL),
    rubocop: defined?(RuboCop),
    rspec: defined?(RSpec),
    factory_bot: defined?(FactoryBot),
    faker: defined?(Faker),
    capybara: defined?(Capybara)
  }
end

# Auto-configure route patterns
def auto_configure_route_patterns(config)
  route_patterns = {
    api_routes: api_routes_detected?,
    html_routes: html_routes_detected?,
    locale_routes: locale_routes_detected?,
    session_routes: session_routes_detected?,
    admin_routes: admin_routes_detected?,
    graphql_routes: graphql_routes_detected?
  }

  # Update features based on route patterns
  config.features.api = route_patterns[:api_routes]
  config.features.graphql = route_patterns[:graphql_routes]
end

# Route pattern detection methods
def api_routes_detected?
  Rails.application.routes.routes.any? { |route|
    route.path.spec.to_s.start_with?('/api/') ||
    route.path.spec.to_s.start_with?('/zeropoint') ||
    route.path.spec.to_s.include?('api')
  }
end

def html_routes_detected?
  Rails.application.routes.routes.any? { |route|
    route.path.spec.to_s.include?('.html') ||
    route.path.spec.to_s.include?('index')
  }
end

def locale_routes_detected?
  Rails.application.routes.routes.any? { |route|
    route.path.spec.to_s.include?('/:locale') ||
    route.path.spec.to_s.include?('/bg/') ||
    route.path.spec.to_s.include?('/en/')
  }
end

def session_routes_detected?
  Rails.application.routes.routes.any? { |route|
    route.path.spec.to_s.include?('session') ||
    route.path.spec.to_s.include?('login') ||
    route.path.spec.to_s.include?('logout')
  }
end

def admin_routes_detected?
  Rails.application.routes.routes.any? { |route|
    route.path.spec.to_s.include?('admin') ||
    route.path.spec.to_s.include?('dashboard')
  }
end

def graphql_routes_detected?
  Rails.application.routes.routes.any? { |route|
    route.path.spec.to_s.include?('graphql') ||
    route.path.spec.to_s.include?('playground')
  }
end

# Configure middleware
def configure_middleware(config)
  # Language detection middleware
  if config.i18n.enabled
    Rails.application.config.middleware.use Zeropoint::LanguageDetectionMiddleware
  end

  # Performance middleware
  if config.performance.enable_compression
    Rails.application.config.middleware.use Rack::Deflater
  end

  # Security middleware
  if config.security.secure_headers
    Rails.application.config.middleware.use Rack::Attack
  end

  # CORS middleware
  if config.api.cors_enabled
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
  end
end

# Configure database optimizations
def configure_database_optimizations(config)
  return unless defined?(ActiveRecord::Base)

  if config.database.connection_pooling
    ActiveRecord::Base.connection_pool.disconnect!
  end

  if config.database.query_optimization
    ActiveRecord::Base.connection.execute("SET enable_seqscan = off;") rescue nil
  end
end

# Configure caching
def configure_caching(config)
  return unless config.cache.enabled

  cache_config = {
    expires_in: config.cache.default_ttl,
    compress: config.cache.compression,
    compress_threshold: config.cache.compression_threshold
  }

  Rails.cache.instance_variable_get(:@data)&.instance_variable_set(:@options, cache_config)
end

# Apply gem-specific configuration
def apply_gem_configuration(config)
  # Redis configuration
  if defined?(Redis) && config.features.caching
    config.cache.redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379/0'
  end

  # Sidekiq configuration
  if defined?(Sidekiq) && config.features.background_jobs
    config.performance.max_threads = ENV.fetch('SIDEKIQ_CONCURRENCY', 10).to_i
  end

  # GraphQL configuration
  if defined?(GraphQL) && config.features.api_graphql
    config.api.graphql_enabled = true
    config.api.playground_enabled = Rails.env.development?
  end
end

# Apply performance optimizations
def apply_performance_optimizations(config)
  # Apply performance profile
  profile = config.performance.speed_level
  Zeropoint::Configuration.apply_performance_profile(profile) if PERFORMANCE_PROFILES.key?(profile.to_sym)

  # Configure thread pool
  Thread.pool_size = [config.performance.max_threads, 16].min if defined?(Thread.pool_size)

  # Configure logging level
  if config.performance.speed_level == 'turbo'
    Rails.logger.level = Logger::WARN unless Rails.env.development?
  elsif config.performance.speed_level == 'fast'
    Rails.logger.level = Logger::INFO unless Rails.env.development?
  end
end

# Apply consciousness configuration
def apply_consciousness_configuration(config)
  return unless config.consciousness.enabled

  # Configure consciousness features
  Zeropoint.config.consciousness.enabled = true
  Zeropoint.config.consciousness.intensive_mode = config.consciousness.intensive_mode

  # Configure insight frequency
  if defined?(Zeropoint::Void::VortexEventEngine)
    Zeropoint::Void::VortexEventEngine.configure(
      insight_frequency: config.consciousness.insight_frequency,
      metaphysical_depth: config.consciousness.metaphysical_depth,
      consciousness_tracking: true
    )
  end
end

# Apply vortex configuration
def apply_vortex_configuration(config)
  return unless config.vortex.enabled

  # Configure vortex features
  Zeropoint.config.vortex.enabled = true
  Zeropoint.config.vortex.encryption_enabled = config.vortex.encryption_enabled
  Zeropoint.config.vortex.caching_enabled = config.vortex.caching_enabled
  Zeropoint.config.vortex.offline_storage_enabled = config.vortex.offline_storage_enabled
end

# Apply security configuration
def apply_security_configuration(config)
  # CSRF protection
  Rails.application.config.action_controller.allow_forgery_protection = config.security.csrf_protection

  # Content Security Policy
  if config.security.content_security_policy
    Rails.application.config.content_security_policy do |policy|
      policy.default_src :self, :https
      policy.font_src    :self, :https, :data
      policy.img_src     :self, :https, :data
      policy.object_src  :none
      policy.script_src  :self, :https
      policy.style_src   :self, :https, :unsafe_inline
    end
  end
end

# Apply API configuration
def apply_api_configuration(config)
  # GraphQL configuration
  if config.api.graphql_enabled
    Rails.application.config.graphql_playground_enabled = config.api.playground_enabled
    Rails.application.config.graphql_introspection_enabled = config.api.introspection_enabled
  end

  # Rate limiting
  if config.api.rate_limiting_enabled
    Rails.application.config.rate_limit = config.api.rate_limit
  end
end

# Apply caching configuration
def apply_caching_configuration(config)
  return unless config.cache.enabled

  # Configure cache store
  if defined?(Redis) && config.features.caching
    Rails.application.config.cache_store = :redis_cache_store, {
      url: config.cache.redis_url || ENV.fetch('REDIS_URL', 'redis://localhost:6379/0'),
      expires_in: config.cache.default_ttl,
      compress: config.cache.compression,
      compress_threshold: config.cache.compression_threshold
    }
  end
end

# Apply internationalization configuration
def apply_i18n_configuration(config)
  return unless config.i18n.enabled

  # Set default locale
  I18n.default_locale = config.i18n.default_locale

  # Set available locales
  I18n.available_locales = config.i18n.available_locales

  # Set fallback locale
  I18n.fallback_locales = [config.i18n.fallback_locale]

  # Load translations
  I18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}')]
  I18n.reload!
end

# Apply development configuration
def apply_development_configuration(config)
  return unless Rails.env.development?

  # Auto-enable development tools
  config.development.better_errors = defined?(BetterErrors)
  config.development.bullet = defined?(Bullet)
  config.development.letter_opener = defined?(LetterOpener)
  config.development.spring = defined?(Spring)
  config.development.listen = defined?(Listen)

  # Configure development middleware
  if config.development.better_errors
    Rails.application.config.middleware.use BetterErrors::Middleware
  end

  if config.development.bullet
    Rails.application.config.after_initialize do
      Bullet.enable = true
      Bullet.rails_logger = true
    end
  end
end

# Apply testing configuration
def apply_testing_configuration(config)
  return unless Rails.env.test?

  # Configure test-specific settings
  config.testing.rspec = defined?(RSpec)
  config.testing.factory_bot = defined?(FactoryBot)
  config.testing.capybara = defined?(Capybara)
  config.testing.coverage = defined?(SimpleCov)
  config.testing.parallel = ENV['PARALLEL_TESTS'] == 'true'
end

# Apply production configuration
def apply_production_configuration(config)
  return unless Rails.env.production?

  # Configure production-specific settings
  config.production.performance_monitoring = true
  config.production.error_tracking = true
  config.production.logging = true
  config.production.caching = true
  config.production.compression = true

  # Configure logging
  if config.production.logging
    Rails.application.config.log_level = ENV.fetch('RAILS_LOG_LEVEL', 'info')
    Rails.application.config.log_tags = [:request_id]
  end
end

# Emit configuration initialized event
def emit_configuration_initialized_event
  return unless defined?(Zeropoint::Void::VortexEventEngine)

  Zeropoint::Void::VortexEventEngine.emit(:configuration_initialized, {
    environment: Rails.env,
    configuration: Zeropoint::Configuration.to_hash,
    timestamp: Time.respond_to?(:current) ? Time.current : Time.now
  })
rescue StandardError
  # Silently fail if VortexEventEngine is not available
end

# Log configuration summary
def log_configuration_summary
  config = Zeropoint::Configuration.to_hash
  
  Rails.logger.info '🌌 Zeropoint Unified Configuration Initialized'
  Rails.logger.info "  Environment: #{Rails.env}"
  Rails.logger.info "  Performance: #{config[:performance][:speed_level]} mode"
  Rails.logger.info "  Consciousness: #{config[:consciousness][:enabled] ? 'enabled' : 'disabled'}"
  Rails.logger.info "  Vortex: #{config[:vortex][:enabled] ? 'enabled' : 'disabled'}"
  Rails.logger.info "  Cache: #{config[:cache][:enabled] ? 'enabled' : 'disabled'}"
  Rails.logger.info "  API: #{config[:api][:graphql_enabled] ? 'GraphQL enabled' : 'GraphQL disabled'}"
  
  # Log enabled features
  enabled_features = config[:features].select { |_, enabled| enabled }.keys
  Rails.logger.info "  Features: #{enabled_features.join(', ')}"
end 