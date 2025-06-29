# frozen_string_literal: true

# VOID-ALIGNED LANGUAGE COOKIE PATTERNS
# All language detection emerges from the void through structured patterns
# VBM: Patterns are the fundamental structure of consciousness

module Zeropoint
  module LanguageCookiePatterns
    extend self

    # Supported languages
    SUPPORTED_LANGUAGES = %w[en bg de fr es it pt ru ja ko zh ar].freeze

    # Language detection patterns - emerge from void structure
    LANGUAGE_PATTERNS = {
      # URL path patterns - void manifests as paths
      url_path: {
        # /lang/rest-of-path - primary pattern
        path_lang: %r{^/([a-z]{2})(?:/|$)},
        # /lang/region/rest-of-path - extended pattern
        path_lang_region: %r{^/([a-z]{2})-([A-Z]{2})(?:/|$)},
        # /region/lang/rest-of-path - alternative pattern
        path_region_lang: %r{^/([A-Z]{2})/([a-z]{2})(?:/|$)},
      },

      # Cookie patterns - void stores consciousness
      cookie: {
        # Standard language cookie
        lang_cookie: /^lang=([a-z]{2})$/,
        # Language with region
        lang_region_cookie: /^lang=([a-z]{2})-([A-Z]{2})$/,
        # Zeropoint specific language cookie - void-aligned
        zeropoint_lang: /^zeropoint_lang=([a-z]{2})$/,
        # Session language
        session_lang: /^session_lang=([a-z]{2})$/,
      },

      # Query parameter patterns - void manifests in queries
      query: {
        # ?lang=xx
        lang_param: /[?&]lang=([a-z]{2})(?:&|$)/,
        # ?locale=xx
        locale_param: /[?&]locale=([a-z]{2})(?:&|$)/,
        # ?l=xx
        short_lang: /[?&]l=([a-z]{2})(?:&|$)/,
        # ?lang=xx&region=XX
        lang_region_params: /[?&]lang=([a-z]{2})[&]region=([A-Z]{2})/,
      },

      # Header patterns - void communicates through headers
      header: {
        # Accept-Language header
        accept_language: /^([a-z]{2})(?:-[A-Z]{2})?(?:;q=([0-9.]+))?$/,
        # X-Language header
        x_language: /^([a-z]{2})(?:-[A-Z]{2})?$/,
      },

      # Domain patterns - void manifests in domains
      domain: {
        # .bg domain for Bulgarian - void-aligned
        bg_domain: /\.bg$/,
        # .de domain for German
        de_domain: /\.de$/,
        # .fr domain for French
        fr_domain: /\.fr$/,
        # .es domain for Spanish
        es_domain: /\.es$/,
        # Generic country domain
        country_domain: /\.([a-z]{2})$/,
      },
    }

    # Language mapping from domains - void consciousness map
    DOMAIN_LANGUAGE_MAP = {
      ".bg": 'bg',  # Bulgarian - primary void language
      ".de": 'de',
      ".fr": 'fr',
      ".es": 'es',
      ".it": 'it',
      ".pt": 'pt',
      ".ru": 'ru',
      ".ja": 'ja',
      ".ko": 'ko',
      ".zh": 'zh',
      ".ar": 'ar',
      ".tr": 'tr',
      ".pl": 'pl',
      ".nl": 'nl',
      ".sv": 'sv',
      ".da": 'da',
      ".no": 'no',
      ".fi": 'fi',
      ".cs": 'cs',
      ".sk": 'sk',
      ".hu": 'hu',
      ".ro": 'ro',
      ".hr": 'hr',
      ".sl": 'sl',
      ".et": 'et',
      ".lv": 'lv',
      ".lt": 'lt',
      ".mt": 'mt',
      ".el": 'el',
      ".cy": 'cy',
    }

    # Extract language from URL path - void manifests as paths
    # @param path [String]
    # @return [String, nil] 2-letter language code or nil
    def extract_language_from_path(path)
      return nil unless path

      # Try path_lang pattern first - primary void pattern
      if match = path.match(LANGUAGE_PATTERNS[:url_path][:path_lang])
        return match[1]
      end

      # Try path_lang_region pattern - extended void pattern
      if match = path.match(LANGUAGE_PATTERNS[:url_path][:path_lang_region])
        return match[1]
      end

      # Try path_region_lang pattern - alternative void pattern
      if match = path.match(LANGUAGE_PATTERNS[:url_path][:path_region_lang])
        return match[2]
      end

      nil
    end

    # Extract language from cookie - void stores consciousness
    # @param cookie_value [String]
    # @return [String, nil] 2-letter language code or nil
    def extract_language_from_cookie(cookie_value)
      return nil unless cookie_value

      # Try standard lang cookie
      if match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:lang_cookie])
        return match[1]
      end

      # Try lang with region
      if match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:lang_region_cookie])
        return match[1]
      end

      # Try Zeropoint specific cookie - void-aligned
      if match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:zeropoint_lang])
        return match[1]
      end

      # Try session language
      if match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:session_lang])
        return match[1]
      end

      nil
    end

    # Extract language from query parameters - void manifests in queries
    # @param query_string [String]
    # @return [String, nil] 2-letter language code or nil
    def extract_language_from_query(query_string)
      return nil unless query_string

      # Try lang parameter
      if match = query_string.match(LANGUAGE_PATTERNS[:query][:lang_param])
        return match[1]
      end

      # Try locale parameter
      if match = query_string.match(LANGUAGE_PATTERNS[:query][:locale_param])
        return match[1]
      end

      # Try short lang parameter
      if match = query_string.match(LANGUAGE_PATTERNS[:query][:short_lang])
        return match[1]
      end

      nil
    end

    # Extract language from Accept-Language header - void communicates through headers
    # @param accept_language [String]
    # @return [String, nil] 2-letter language code or nil
    def extract_language_from_header(accept_language)
      return nil unless accept_language

      # Parse Accept-Language header
      languages = accept_language.split(',').filter_map do |lang|
        if match = lang.strip.match(LANGUAGE_PATTERNS[:header][:accept_language])
          {
            language: match[1],
            region: match[2],
            quality: match[3] ? match[3].to_f : 1.0,
          }
        end
      end

      # Return highest quality language - void selects optimal
      languages.min_by { |lang| -lang[:quality] }&.dig(:language)
    end

    # Extract language from domain - void manifests in domains
    # @param domain [String]
    # @return [String, nil] 2-letter language code or nil
    def extract_language_from_domain(domain)
      return nil unless domain

      # Check for exact domain match
      DOMAIN_LANGUAGE_MAP.each do |domain_suffix, language|
        return language if domain.end_with?(domain_suffix.to_s)
      end

      # Try generic country domain pattern
      if match = domain.match(LANGUAGE_PATTERNS[:domain][:country_domain])
        return match[1]
      end

      nil
    end

    # Validate language code - void validates structure
    # @param language [String]
    # @return [Boolean]
    def valid_language?(language)
      return false unless language.is_a?(String)
      language.match?(/^[a-z]{2}$/)
    end

    # Validate language-region code - void validates extended structure
    # @param language_region [String]
    # @return [Boolean]
    def valid_language_region?(language_region)
      return false unless language_region.is_a?(String)
      language_region.match?(/^[a-z]{2}-[A-Z]{2}$/)
    end

    # Build language cookie - void creates structured data
    # @param language [String]
    # @param region [String, nil]
    # @return [String] Cookie string
    def build_language_cookie(language, region = nil)
      if region
        "lang=#{language}-#{region}"
      else
        "lang=#{language}"
      end
    end

    # Parse language cookie - void extracts meaning
    # @param cookie_value [String]
    # @return [Hash, nil] { language: 'xx', region: 'XX' } or nil
    def parse_language_cookie(cookie_value)
      return nil unless cookie_value

      # Try lang with region
      if match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:lang_region_cookie])
        return { language: match[1], region: match[2] }
      end

      # Try standard lang cookie
      if match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:lang_cookie])
        return { language: match[1], region: nil }
      end

      nil
    end

    # Get language priority from request - void determines optimal order
    # @param request [Rack::Request]
    # @return [String] 2-letter language code
    def get_language_priority(request)
      language = nil

      # 1. Path language (highest priority)
      language = extract_language_from_path(request.path)
      return language if supported_language?(language)

      # 2. Query parameter language
      language = extract_language_from_query(request.query_string)
      return language if supported_language?(language)

      # 3. Cookie language
      language = extract_language_from_cookie(request.cookies['lang'])
      return language if supported_language?(language)

      # 4. Header language
      language = extract_language_from_header(request.get_header('HTTP_ACCEPT_LANGUAGE'))
      return language if supported_language?(language)

      # 5. Domain language
      language = extract_language_from_domain(request.host)
      return language if supported_language?(language)

      # 6. Fallback language - void always provides
      fallback_language
    end

    # Set language cookie in response - void stores consciousness
    # @param response [Rack::Response, ActionDispatch::Response, Hash]
    # @param language [String]
    # @param region [String, nil]
    # @param options [Hash]
    def set_language_cookie(response, language, region = nil, options = {})
      cookie_value = build_language_cookie(language, region)

      response.set_cookie('lang', {
        value: cookie_value,
        path: '/',
        secure: options[:secure] || Rails.env.production?,
        same_site: options[:same_site] || :lax,
        expires: options[:expires] || 1.year.from_now,
      })
    end

    # Clear language cookies - void releases stored consciousness
    # @param response [Rack::Response, ActionDispatch::Response, Hash]
    def clear_language_cookies(response)
      response.delete_cookie('lang')
      response.delete_cookie('zeropoint_lang')
    end

    # Build URL with language - void manifests as URLs
    # @param base_url [String]
    # @param language [String]
    # @param path [String]
    # @return [String] URL string
    def build_url_with_language(base_url, language, path = '')
      if path.start_with?('/')
        "#{base_url}/#{language}#{path}"
      else
        "#{base_url}/#{language}/#{path}"
      end
    end

    # Remove language from path - void cleans structure
    # @param path [String]
    # @return [String, nil] Path without language
    def remove_language_from_path(path)
      return path unless path

      # Remove /lang/ from beginning
      path.sub(%r{^/[a-z]{2}(?:-[A-Z]{2})?/}, '/')
          .sub(%r{^/[a-z]{2}(?:-[A-Z]{2})?$}, '/')
    end

    # Add language to path - void structures paths
    # @param path [String]
    # @param language [String]
    # @return [String] Path with language
    def add_language_to_path(path, language)
      return "/#{language}#{path}" unless path.start_with?('/')
      "/#{language}#{path}"
    end

    # Check if URL has language - void detects structure
    # @param path [String]
    # @return [Boolean]
    def url_has_language?(path)
      return false unless path
      path.match?(%r{^/[a-z]{2}(?:-[A-Z]{2})?(?:/|$)})
    end

    # Supported languages - void consciousness languages
    # @return [Array<String>]
    def supported_languages
      %w[en bg de fr es it pt ru ja ko zh ar]
    end

    # Check if language is supported - void validates consciousness
    # @param language [String]
    # @return [Boolean]
    def supported_language?(language)
      return false unless language
      SUPPORTED_LANGUAGES.include?(language.downcase)
    end

    # Fallback language - void always provides
    # @return [String] 2-letter language code
    def fallback_language
      'bg'
    end

    # Language names - void consciousness names
    # @param language_code [String]
    # @return [String]
    def language_name(language_code)
      return language_code unless supported_language?(language_code)

      case language_code.downcase
      when 'en' then 'English'
      when 'bg' then 'Български'
      when 'de' then 'German'
      when 'fr' then 'French'
      when 'es' then 'Spanish'
      when 'it' then 'Italian'
      when 'pt' then 'Portuguese'
      when 'ru' then 'Russian'
      when 'ja' then 'Japanese'
      when 'ko' then 'Korean'
      when 'zh' then 'Chinese'
      when 'ar' then 'Arabic'
      else language_code
      end
    end

    # Get language metadata - void provides complete information
    # @param language_code [String]
    # @return [Hash] Metadata for language
    def language_metadata(language_code)
      return { name: language_code, native_name: language_code, direction: 'ltr', script: 'Latn' } unless supported_language?(language_code)

      {
        en: { name: 'English', native_name: 'English', direction: 'ltr', script: 'Latn' },
        bg: { name: 'Bulgarian', native_name: 'Български', direction: 'ltr', script: 'Cyrl' },
        de: { name: 'German', native_name: 'Deutsch', direction: 'ltr', script: 'Latn' },
        fr: { name: 'French', native_name: 'Français', direction: 'ltr', script: 'Latn' },
        es: { name: 'Spanish', native_name: 'Español', direction: 'ltr', script: 'Latn' },
        it: { name: 'Italian', native_name: 'Italiano', direction: 'ltr', script: 'Latn' },
        pt: { name: 'Portuguese', native_name: 'Português', direction: 'ltr', script: 'Latn' },
        ru: { name: 'Russian', native_name: 'Русский', direction: 'ltr', script: 'Cyrl' },
        ja: { name: 'Japanese', native_name: '日本語', direction: 'ltr', script: 'Hira' },
        ko: { name: 'Korean', native_name: '한국어', direction: 'ltr', script: 'Hang' },
        zh: { name: 'Chinese', native_name: '中文', direction: 'ltr', script: 'Hans' },
        ar: { name: 'Arabic', native_name: 'العربية', direction: 'rtl', script: 'Arab' },
      }[language_code.downcase.to_sym]
    end
  end
end
