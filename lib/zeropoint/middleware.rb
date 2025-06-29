# frozen_string_literal: true

module Zeropoint
  module GraphQL
    # GraphQL Context Middleware
    class ContextMiddleware
      def initialize(app)
        @app = app
      end

      def call(env)
        # Add GraphQL context to request
        env['graphql.context'] = build_context(env)

        @app.call(env)
      end

      private

      def build_context(env)
        {
          request_id: env['action_dispatch.request_id'],
          ip_address: env['REMOTE_ADDR'],
          user_agent: env['HTTP_USER_AGENT'],
          locale: extract_locale(env),
          consciousness_enabled: Zeropoint.config.consciousness_aware_errors,
          vortex_enabled: Zeropoint.config.vortex_enabled,
        }
      end

      def extract_locale(env)
        # Extract locale from request headers or params
        env['HTTP_ACCEPT_LANGUAGE']&.split(',')&.first&.split('-')&.first || I18n.default_locale
      end
    end
  end

  module Internationalization
    # Internationalization Middleware
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        # Set locale from request
        locale = extract_locale(env)
        I18n.with_locale(locale) do
          @app.call(env)
        end
      end

      private

      def extract_locale(env)
        # Extract locale from various sources
        locale = env['HTTP_ACCEPT_LANGUAGE']&.split(',')&.first&.split('-')&.first ||
                env['rack.request.query_hash']&.fetch('locale', nil) ||
                env['action_dispatch.request.parameters']&.fetch('locale', nil) ||
                I18n.default_locale

        # Validate locale
        locale = locale.to_sym
        locale = I18n.default_locale unless Zeropoint.config.available_locales.include?(locale)

        locale
      end
    end
  end

  module Consciousness
    # Consciousness Error Middleware
    class ErrorMiddleware
      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env)
      rescue StandardError => e
        # Apply consciousness-aware error handling
        consciousness_error = ErrorHandler.handle(e, {
          source: 'middleware',
          env: env.except('rack.input', 'rack.errors'),
          timestamp: Time.current,
        })

        # Re-raise the consciousness error
        raise consciousness_error
      end
    end
  end
end
