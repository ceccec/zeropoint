# frozen_string_literal: true

# Zeropoint Initializer
# This file initializes the Zeropoint gem for your Rails application

require 'zeropoint'

# Load configuration
Zeropoint.configure do |config|
  # Load configuration from YAML file
  config_file = Rails.root.join('config/zeropoint.yml')

  if File.exist?(config_file)
    yaml_config = YAML.load_file(config_file)[Rails.env] || {}

    # Authentication configuration
    if yaml_config['authentication']
      config.authentication.enabled = yaml_config['authentication']['enabled']
      config.authentication.provider = yaml_config['authentication']['provider']
      config.authentication.session_timeout = yaml_config['authentication']['session_timeout']
      config.authentication.password_min_length = yaml_config['authentication']['password_min_length']
      config.authentication.require_email_confirmation = yaml_config['authentication']['require_email_confirmation']
    end

    # GraphQL configuration
    if yaml_config['graphql']
      config.graphql.enabled = yaml_config['graphql']['enabled']
      config.graphql.playground_enabled = yaml_config['graphql']['playground_enabled']
      config.graphql.introspection_enabled = yaml_config['graphql']['introspection_enabled']
      config.graphql.max_complexity = yaml_config['graphql']['max_complexity']
      config.graphql.max_depth = yaml_config['graphql']['max_depth']
    end

    # Vortex configuration
    if yaml_config['vortex']
      config.vortex.enabled = yaml_config['vortex']['enabled']
      config.vortex.encryption_enabled = yaml_config['vortex']['encryption_enabled']
      config.vortex.caching_enabled = yaml_config['vortex']['caching_enabled']
      config.vortex.offline_storage_enabled = yaml_config['vortex']['offline_storage_enabled']
      config.vortex.batch_size = yaml_config['vortex']['batch_size']
      config.vortex.stream_timeout = yaml_config['vortex']['stream_timeout']
    end

    # Internationalization configuration
    if yaml_config['i18n']
      config.i18n.enabled = yaml_config['i18n']['enabled']
      config.i18n.default_locale = yaml_config['i18n']['default_locale']
      config.i18n.available_locales = yaml_config['i18n']['available_locales']
      config.i18n.fallback_locale = yaml_config['i18n']['fallback_locale']
    end

    # Consciousness configuration
    if yaml_config['consciousness']
      config.consciousness.enabled = yaml_config['consciousness']['enabled']
      config.consciousness.observer_influence = yaml_config['consciousness']['observer_influence']
      config.consciousness.quantum_entanglement = yaml_config['consciousness']['quantum_entanglement']
      config.consciousness.golden_ratio_integration = yaml_config['consciousness']['golden_ratio_integration']
    end

    # API configuration
    if yaml_config['api']
      config.api.version = yaml_config['api']['version']
      config.api.rate_limiting_enabled = yaml_config['api']['rate_limiting_enabled']
      config.api.rate_limit = yaml_config['api']['rate_limit']
      config.api.cors_enabled = yaml_config['api']['cors_enabled']
    end

    # Security configuration
    if yaml_config['security']
      config.security.csrf_protection = yaml_config['security']['csrf_protection']
      config.security.content_security_policy = yaml_config['security']['content_security_policy']
      config.security.secure_headers = yaml_config['security']['secure_headers']
      config.security.encryption_algorithm = yaml_config['security']['encryption_algorithm']
      config.security.key_rotation_interval = yaml_config['security']['key_rotation_interval']
    end
  end
end

# Initialize Zeropoint components
Zeropoint.initialize!

# Log initialization
Rails.logger.info "Zeropoint initialized successfully in #{Rails.env} environment"
