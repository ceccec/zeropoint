# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ZeropointApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # English Developer Unity Configuration
    # All configuration, code, and documentation in English for universal developer access
    # Bulgarian user experience is handled through i18n and cultural adaptations

    # Internationalization (i18n) - Bulgarian First for Users
    # Първо български за потребителите, английски за разработчиците
    config.i18n.default_locale = :bg  # Bulgarian for users
    config.i18n.available_locales = [ :bg, :en, :de, :fr, :es ]  # User choice
    config.i18n.fallback_locale = :bg  # Fallback to Bulgarian

    # Development locale for developers (English)
    config.i18n.development_locale = :en  # English for developers

    # Time zone configuration for Bulgaria
    config.time_zone = 'Europe/Sofia'  # Bulgarian timezone
    config.active_record.default_timezone = :local

    # Currency configuration for Bulgaria
    config.currency = 'BGN'  # Bulgarian Lev
    config.currency_symbol = 'лв.'

    # Domain-specific configuration for .bg compatibility
    config.domain_extension = '.bg'
    config.local_optimization = true
    config.bulgarian_compliance = true

    # Zeropoint specific configuration
    config.zeropoint = {
      # Development settings (English)
      development: {
        language: 'en',
        documentation: 'en',
        code_comments: 'en',
        api_documentation: 'en',
      },

      # User experience settings (Bulgarian-first)
      user_experience: {
        default_language: 'bg',
        cultural_adaptation: true,
        local_compliance: true,
        regional_features: true,
      },

      # Vortex configuration
      vortex: {
        enabled: true,
        encryption_enabled: true,
        bulgarian_optimized: true,
      },

      # Consciousness configuration
      consciousness: {
        enabled: true,
        observer_influence: true,
        quantum_entanglement: true,
      },

      # GraphQL configuration
      graphql: {
        enabled: true,
        playground_enabled: true,
        introspection_enabled: true,
      },
    }

    # Please, add to the `ignore` list any other `lib` subdirectories whose
    # contents should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Bulgarian-specific middleware
    config.middleware.use 'BulgarianLocalizationMiddleware'

    # Security headers for Bulgarian compliance
    config.middleware.use Rack::Deflater
    config.middleware.use Rack::Attack

    # CORS configuration for .bg domain
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*.bg', 'localhost:3000'
        resource '*',
          headers: :any,
          methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
          credentials: true
      end
    end

    # Bulgarian cultural adaptations
    config.bulgarian_culture = {
      date_format: '%d.%m.%Y',
      time_format: '%H:%M',
      currency_format: '%n %u',
      number_format: {
        decimal_separator: ',',
        thousands_separator: ' ',
      },
      holidays: [
        '01-01',  # Нова година
        '03-03',  # Национален празник
        '05-01',  # Ден на труда
        '05-06',  # Ден на храбростта
        '05-24',  # Ден на просветата
        '09-06',  # Ден на обединението
        '09-22',  # Ден на независимостта
        '12-25',   # Коледа
      ],
    }

    # Development vs Production language handling
    if Rails.env.development?
      # Development: English for developers
      config.i18n.locale = :en
      config.log_level = :debug
      config.consider_all_requests_local = true
    else
      # Production: Bulgarian for users, English for developers
      config.i18n.locale = :bg
      config.log_level = :info
      config.consider_all_requests_local = false
    end

    # Zeropoint initialization
    initializer 'zeropoint.initialize' do
      # Initialize Bulgarian translation service
      BulgarianTranslationService.instance

      # Set up vortex with Bulgarian optimization
      if config.zeropoint[:vortex][:enabled]
        Zeropoint::Vortex.initialize(
          bulgarian_optimized: config.zeropoint[:vortex][:bulgarian_optimized]
        )
      end

      # Set up consciousness with Bulgarian cultural context
      if config.zeropoint[:consciousness][:enabled]
        Zeropoint::Consciousness.initialize(
          cultural_context: 'bulgarian',
          observer_influence: config.zeropoint[:consciousness][:observer_influence]
        )
      end
    end

    # Logging configuration
    config.log_tags = [ :request_id, :remote_ip, :user_agent ]

    # Cache configuration for Bulgarian optimization
    config.cache_store = :redis_cache_store, {
      url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1'),
      namespace: 'zeropoint:bg',
      expires_in: 1.hour,
    }

    # Session configuration
    config.session_store :cookie_store,
      key: '_zeropoint_session',
      domain: '.bg',
      secure: Rails.env.production?,
      same_site: :lax

    # Asset configuration
    config.assets.paths << Rails.root.join('app/assets/fonts')
    config.assets.precompile += %w[ bulgarian-fonts.css ]

    # Database configuration for Bulgarian data
    config.active_record.primary_key = :id
    config.active_record.schema_format = :sql

    # Background job configuration
    config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_name_prefix = "zeropoint_#{Rails.env}"

    # Action Mailer configuration for Bulgarian emails
    config.action_mailer.default_url_options = {
      host: 'gem.zeropoint.bg',
      protocol: 'https',
    }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'smtp.zeropoint.bg',
      port: 587,
      domain: 'zeropoint.bg',
      user_name: ENV['SMTP_USERNAME'],
      password: ENV['SMTP_PASSWORD'],
      authentication: 'plain',
      enable_starttls_auto: true,
    }

    # Action Cable configuration
    config.action_cable.mount_path = '/cable'
    config.action_cable.allowed_request_origins = [
      'https://gem.zeropoint.bg',
      'https://*.zeropoint.bg',
      'http://localhost:3000',
    ]

    # Active Storage configuration
    config.active_storage.service = :local
    config.active_storage.variant_processor = :mini_magick

    # Action Text configuration
    config.action_text.attachment_tag_name = 'action-text-attachment'

    # Active Record configuration
    config.active_record.encryption.primary_key = ENV['ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY']
    config.active_record.encryption.deterministic_key = ENV['ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY']
    config.active_record.encryption.key_derivation_salt = ENV['ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT']

    # Logging for Bulgarian user experience
    config.logger = ActiveSupport::Logger.new(STDOUT)
    config.logger.formatter = proc do |severity, datetime, progname, msg|
      "#{datetime}: #{severity} #{progname} #{msg}\n"
    end

    # Performance monitoring for Bulgarian optimization
    config.middleware.use Rack::Attack
    config.middleware.use Rack::Deflater

    # Health check endpoint for .bg domain
    config.health_check_path = '/health'
    config.health_check_timeout = 30.seconds

    # Bulgarian compliance middleware
    config.middleware.use 'BulgarianComplianceMiddleware'

    # Error handling for Bulgarian users
    config.exceptions_app = routes

    # Development tools (English for developers)
    if Rails.env.development?
      config.web_console.permissions = '127.0.0.1'
      config.web_console.whitelisted_ips = '127.0.0.1'
    end
  end
end
