# frozen_string_literal: true

# COMPONENT BEST PRACTICE: Use I18n with fallbacks for all language operations.

# Zeropoint::LanguageHelper
#
# Helper methods for working with language URLs, cookies, and detection.
# Provides language switcher, current language, and language-aware URL helpers.
# VOID-ALIGNED: All language operations emerge from void patterns
#
# @see app/middleware/zeropoint/language_detection_middleware.rb
#
module Zeropoint
  module LanguageHelper
    include Zeropoint::LanguageCookiePatterns

    # Returns the current detected language for the request.
    # @return [String] language code
    def current_language
      # COMPONENT BEST PRACTICE: Return the current I18n locale.
      @current_language ||= detect_current_language
    end

    # Returns the display name for the current language.
    # @return [String]
    def current_language_name
      Zeropoint::LanguageCookiePatterns.language_name(current_language)
    end

    # Returns true if the current language matches the given code.
    # @param language [String]
    # @return [Boolean]
    def current_language?(language)
      current_language == language
    end

    # Returns a URL for the current page in the given language.
    # @param language [String]
    # @return [String]
    def language_url(language)
      return current_url unless Zeropoint::LanguageCookiePatterns.supported_language?(language)

      current_path = request.path
      current_query = request.query_string.present? ? "?#{request.query_string}" : ''
      clean_path = Zeropoint::LanguageCookiePatterns.remove_language_from_path(current_path)
      new_path = Zeropoint::LanguageCookiePatterns.add_language_to_path(clean_path, language)
      "#{request.base_url}#{new_path}#{current_query}"
    end

    # Returns a path for the given path in the given language.
    # @param path [String]
    # @param language [String]
    # @return [String]
    def language_path(path, language)
      return path unless Zeropoint::LanguageCookiePatterns.supported_language?(language)

      clean_path = Zeropoint::LanguageCookiePatterns.remove_language_from_path(path)
      Zeropoint::LanguageCookiePatterns.add_language_to_path(clean_path, language)
    end

    # Sets the language cookie for the user.
    # @param language [String]
    # @param region [String, nil]
    def set_language_cookie(language, region = nil)
      return unless Zeropoint::LanguageCookiePatterns.supported_language?(language)

      cookie_value = Zeropoint::LanguageCookiePatterns.build_language_cookie(language, region)
      cookies[:lang] = {
        value: cookie_value,
        path: '/',
        secure: Rails.env.production?,
        same_site: :lax,
        expires: 1.year.from_now,
      }
      cookies[:zeropoint_lang] = {
        value: cookie_value,
        path: '/',
        secure: Rails.env.production?,
        same_site: :lax,
        expires: 1.year.from_now,
      }
    end

    # Returns an array of language switcher links for the UI.
    # @return [Array<Hash>]
    def language_switcher_links
      supported_languages.map do |language|
        {
          language: language,
          name: Zeropoint::LanguageCookiePatterns.language_name(language),
          url: language_url(language),
          current: current_language?(language),
        }
      end
    end

    # Detects the current language from the request using all sources.
    # @return [String]
    def detect_current_language
      language = Zeropoint::LanguageCookiePatterns.extract_language_from_path(request.path)
      return language if Zeropoint::LanguageCookiePatterns.supported_language?(language)

      language = language_from_cookie('lang')
      return language if Zeropoint::LanguageCookiePatterns.supported_language?(language)

      language = language_from_cookie('zeropoint_lang')
      return language if Zeropoint::LanguageCookiePatterns.supported_language?(language)

      language = language_from_header
      return language if Zeropoint::LanguageCookiePatterns.supported_language?(language)

      language = language_from_domain
      return language if Zeropoint::LanguageCookiePatterns.supported_language?(language)

      Zeropoint::LanguageCookiePatterns.fallback_language
    end

    # Extracts language from a cookie by name.
    # @param cookie_name [String]
    # @return [String, nil]
    def language_from_cookie(cookie_name = 'lang')
      cookie_value = cookies[cookie_name]
      return nil unless cookie_value

      Zeropoint::LanguageCookiePatterns.extract_language_from_cookie("#{cookie_name}=#{cookie_value}")
    end

    # Extracts language from the Accept-Language header.
    # @return [String, nil]
    def language_from_header
      Zeropoint::LanguageCookiePatterns.extract_language_from_header(request.headers['Accept-Language'])
    end

    # Extracts language from the domain.
    # @param domain [String, nil]
    # @return [String, nil]
    def language_from_domain(domain = nil)
      domain ||= request.host
      Zeropoint::LanguageCookiePatterns.extract_language_from_domain(domain)
    end

    # Redirects to the current page in the given language.
    # @param language [String]
    def redirect_to_language(language)
      return unless Zeropoint::LanguageCookiePatterns.supported_language?(language)

      set_language_cookie(language)
      redirect_to language_url(language)
    end
  end
end
