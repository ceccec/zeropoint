require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ZeropointRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Set a default, will be overridden in initializer
    config.api_only = false

    # Initialize Zeropoint features config
    config.zeropoint_features = {}

    # API-only detection logic in initializer
    initializer "zeropoint.api_only_detection", before: :set_autoload_paths do |app|
      api_only_env = ENV["ZEROPOINT_API_ONLY"] == "true"
      root_defined = app.routes.routes.any? { |route| route.name == "root" } rescue true
      app.config.api_only = api_only_env || !root_defined
    end

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Load Zeropoint
    require "zeropoint"

    # Configure Zeropoint
    Zeropoint.configure do |config|
      config.consciousness_aware_errors = true
    end

    # Initialize intelligent auto-detection after Rails is loaded
    initializer "zeropoint.intelligent_detection", after: :load_config_initializers do
      self.class.auto_configure_intelligent_features
    end

    class << self
      def defined_root_path?
        # Check if root_path is defined in routes
        Rails.application.routes.routes.any? { |route| route.name == "root" }
      rescue
        # If routes haven't been loaded yet, assume root_path is defined
        true
      end

      # Comprehensive intelligent auto-detection system
      def auto_configure_intelligent_features
        auto_configure_middleware
        auto_configure_database_features
        auto_configure_gem_features
        auto_configure_route_patterns
        auto_configure_development_tools
        log_intelligent_configuration
      end

      private

      # Auto-configure middleware based on route patterns
      def auto_configure_middleware
        config = Rails.application.config

        # Auto-enable CORS if API routes detected
        if api_routes_detected?
          config.middleware.use Rack::Cors unless middleware_loaded?(Rack::Cors)
          Rails.logger.info "🌐 Auto-enabled CORS for API routes"
        end

        # Auto-enable compression if HTML routes detected
        if html_routes_detected?
          config.middleware.use Rack::Deflater unless middleware_loaded?(Rack::Deflater)
          Rails.logger.info "🗜️ Auto-enabled compression for HTML routes"
        end

        # Auto-enable language middleware if locale routes detected
        if locale_routes_detected?
          # Note: Language middleware would be added here if available
          Rails.logger.info "🌍 Auto-detected locale routes for language middleware"
        end

        # Auto-enable session middleware if session routes detected
        if session_routes_detected?
          config.middleware.use ActionDispatch::Session::CookieStore unless middleware_loaded?(ActionDispatch::Session::CookieStore)
          Rails.logger.info "🍪 Auto-enabled session middleware"
        end
      end

      # Auto-configure database features based on adapter
      def auto_configure_database_features
        return unless defined?(ActiveRecord::Base) && ActiveRecord::Base.connected?

        adapter = ActiveRecord::Base.connection.adapter_name.downcase
        config = Rails.application.config

        case adapter
        when "postgresql"
          config.zeropoint_features ||= {}
          config.zeropoint_features[:full_text_search] = true
          config.zeropoint_features[:json_queries] = true
          config.zeropoint_features[:trigram_similarity] = true
          Rails.logger.info "🐘 Auto-enabled PostgreSQL features: full-text search, JSON queries, trigram similarity"
        when "mysql"
          config.zeropoint_features ||= {}
          config.zeropoint_features[:full_text_search] = true
          config.zeropoint_features[:json_queries] = true
          Rails.logger.info "🐬 Auto-enabled MySQL features: full-text search, JSON queries"
        when "sqlite"
          config.zeropoint_features ||= {}
          config.zeropoint_features[:full_text_search] = false
          config.zeropoint_features[:json_queries] = false
          Rails.logger.info "📱 Auto-configured SQLite features"
        end
      rescue => e
        Rails.logger.warn "⚠️ Could not auto-configure database features: #{e.message}"
      end

      # Auto-configure features based on available gems
      def auto_configure_gem_features
        config = Rails.application.config
        config.zeropoint_features ||= {}

        # Detect available gems and configure features
        gem_features = {
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

        config.zeropoint_features[:available_gems] = gem_features

        # Auto-enable features based on available gems
        config.zeropoint_features[:background_jobs] = gem_features[:sidekiq]
        config.zeropoint_features[:caching] = gem_features[:redis]
        config.zeropoint_features[:search] = gem_features[:elasticsearch]
        config.zeropoint_features[:api_graphql] = gem_features[:graphql]
        config.zeropoint_features[:code_quality] = gem_features[:rubocop]
        config.zeropoint_features[:testing] = gem_features[:rspec]

        enabled_features = gem_features.select { |_, available| available }.keys
        Rails.logger.info "💎 Auto-detected gems: #{enabled_features.join(', ')}"
      end

      # Auto-configure based on route patterns
      def auto_configure_route_patterns
        config = Rails.application.config
        config.zeropoint_features ||= {}

        route_patterns = {
          api_routes: api_routes_detected?,
          html_routes: html_routes_detected?,
          locale_routes: locale_routes_detected?,
          session_routes: session_routes_detected?,
          admin_routes: admin_routes_detected?,
          graphql_routes: graphql_routes_detected?
        }

        config.zeropoint_features[:route_patterns] = route_patterns

        detected_patterns = route_patterns.select { |_, detected| detected }.keys
        Rails.logger.info "🛣️ Auto-detected route patterns: #{detected_patterns.join(', ')}"
      end

      # Auto-configure development tools
      def auto_configure_development_tools
        return unless Rails.env.development?

        config = Rails.application.config
        config.zeropoint_features ||= {}

        # Auto-enable development tools
        config.zeropoint_features[:development_tools] = {
          better_errors: defined?(BetterErrors),
          bullet: defined?(Bullet),
          letter_opener: defined?(LetterOpener),
          spring: defined?(Spring),
          listen: defined?(Listen)
        }

        # Auto-configure development middleware
        if defined?(BetterErrors)
          config.middleware.use BetterErrors::Middleware unless middleware_loaded?(BetterErrors::Middleware)
        end

        if defined?(Bullet)
          config.after_initialize do
            Bullet.enable = true
            Bullet.rails_logger = true
          end
        end

        Rails.logger.info "🔧 Auto-configured development tools"
      end

      # Route pattern detection methods
      def api_routes_detected?
        Rails.application.routes.routes.any? { |route|
          route.path.spec.to_s.start_with?("/api/") ||
          route.path.spec.to_s.start_with?("/zeropoint") ||
          route.path.spec.to_s.include?("api")
        }
      end

      def html_routes_detected?
        Rails.application.routes.routes.any? { |route|
          route.path.spec.to_s.match?(/\.[html|erb]$/) ||
          route.name == "root" ||
          route.path.spec.to_s.match?(/pages|views/)
        }
      end

      def locale_routes_detected?
        Rails.application.routes.routes.any? { |route|
          route.path.spec.to_s.match?(/\{locale\}|\/:[a-z]{2}\//) ||
          route.path.spec.to_s.include?("language")
        }
      end

      def session_routes_detected?
        Rails.application.routes.routes.any? { |route|
          route.path.spec.to_s.match?(/session|login|logout|auth/) ||
          route.name&.match?(/session|login|logout|auth/)
        }
      end

      def admin_routes_detected?
        Rails.application.routes.routes.any? { |route|
          route.path.spec.to_s.start_with?("/admin") ||
          route.name&.start_with?("admin")
        }
      end

      def graphql_routes_detected?
        Rails.application.routes.routes.any? { |route|
          route.path.spec.to_s.include?("graphql") ||
          route.name&.include?("graphql")
        }
      end

      # Check if middleware is already loaded
      def middleware_loaded?(middleware_class)
        Rails.application.middleware.any? { |middleware|
          middleware.klass == middleware_class ||
          middleware.klass.name == middleware_class.name
        }
      rescue
        false
      end

      # Log intelligent configuration summary
      def log_intelligent_configuration
        config = Rails.application.config
        features = config.zeropoint_features || {}

        Rails.logger.info "🧠 Zeropoint Intelligent Configuration Summary:"
        Rails.logger.info "   API Mode: #{config.api_only ? 'API-only' : 'Full-stack'}"
        Rails.logger.info "   Database Features: #{features[:full_text_search] ? 'Full-text search' : 'Basic'}"
        Rails.logger.info "   Available Gems: #{features.dig(:available_gems)&.select { |_, v| v }&.keys&.join(', ') || 'None detected'}"
        Rails.logger.info "   Route Patterns: #{features.dig(:route_patterns)&.select { |_, v| v }&.keys&.join(', ') || 'None detected'}"
        Rails.logger.info "   Development Tools: #{features.dig(:development_tools)&.select { |_, v| v }&.keys&.join(', ') || 'None detected'}"
      end
    end
  end
end
