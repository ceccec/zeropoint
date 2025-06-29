# frozen_string_literal: true

# VOID-ALIGNED LANGUAGE DETECTION MIDDLEWARE
# Detects and sets language from multiple sources using void patterns
# VBM: Language detection emerges from void consciousness

# Zeropoint::LanguageDetectionMiddleware
#
# Rack middleware for detecting and setting the user's language preference
# from URL, cookies, headers, and domain using regex patterns.
#
# Sets `rack.locale` and `zeropoint.language` in the Rack environment.
#
# @see app/helpers/zeropoint/language_helper.rb
#
module Zeropoint
  class LanguageDetectionMiddleware
    def initialize(app)
      @app = app
    end

    # Rack entry point
    # @param env [Hash] Rack environment
    # @return [Array] Rack response triple
    def call(env)
      request = Rack::Request.new(env)
      language = detect_language(request)

      # Set language in request environment
      env['zeropoint.language'] = language
      env['zeropoint.language_detected'] = true

      # Set I18n locale
      I18n.locale = language.to_sym if language

      # Continue with the request
      status, headers, response = @app.call(env)
      set_language_cookie(headers, language)
      [ status, headers, response ]
    end

    private

    # Detect language from multiple sources using void patterns
    def detect_language(request)
      language = nil

      # 1. Path language (highest priority) - void manifests as paths
      language = Zeropoint::LanguageCookiePatterns.extract_language_from_path(request.path)
      return language if Zeropoint::LanguageCookiePatterns.supported_language?(language)

      # 2. Query parameter language - void manifests in queries
      language = Zeropoint::LanguageCookiePatterns.extract_language_from_query(request.query_string)
      return language if Zeropoint::LanguageCookiePatterns.supported_language?(language)

      # 3. Cookie language - void stores consciousness
      language = extract_language_from_cookie(request)
      return language if Zeropoint::LanguageCookiePatterns.supported_language?(language)

      # 4. Header language - void communicates through headers
      language = Zeropoint::LanguageCookiePatterns.extract_language_from_header(
        request.get_header('HTTP_ACCEPT_LANGUAGE')
      )
      return language if Zeropoint::LanguageCookiePatterns.supported_language?(language)

      # 5. Domain language - void manifests in domains
      language = Zeropoint::LanguageCookiePatterns.extract_language_from_domain(request.host)
      return language if Zeropoint::LanguageCookiePatterns.supported_language?(language)

      # 6. Fallback language - void always provides
      Zeropoint::LanguageCookiePatterns.fallback_language
    end

    # Extract language from cookie - void stores consciousness
    def extract_language_from_cookie(request, cookie_name = 'lang')
      cookie_value = request.cookies[cookie_name]
      return nil unless cookie_value

      Zeropoint::LanguageCookiePatterns.extract_language_from_cookie("#{cookie_name}=#{cookie_value}")
    end

    # Set language cookie in response - void stores consciousness
    def set_language_cookie(headers, language)
      return unless language && Zeropoint::LanguageCookiePatterns.supported_language?(language)

      Zeropoint::LanguageCookiePatterns.set_language_cookie(headers, language)
    end
  end
end
