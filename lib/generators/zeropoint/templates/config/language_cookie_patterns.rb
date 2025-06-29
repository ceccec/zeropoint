# frozen_string_literal: true

# Language Cookie Patterns for Zeropoint
# Regex patterns for URL cookies to handle language detection and switching

module LanguageCookiePatterns
  # Language detection patterns
  LANGUAGE_PATTERNS = {
    # URL path patterns
    url_path: {
      # /lang/rest-of-path
      path_lang: %r{^/([a-z]{2})(?:/|$)},
      # /lang/region/rest-of-path
      path_lang_region: %r{^/([a-z]{2})-([A-Z]{2})(?:/|$)},
      # /region/lang/rest-of-path
      path_region_lang: %r{^/([A-Z]{2})/([a-z]{2})(?:/|$)},
    },

    # Cookie patterns
    cookie: {
      # Standard language cookie
      lang_cookie: /^lang=([a-z]{2})$/,
      # Language with region
      lang_region_cookie: /^lang=([a-z]{2})-([A-Z]{2})$/,
      # Zeropoint specific language cookie
      zeropoint_lang: /^zeropoint_lang=([a-z]{2})$/,
      # Session language
      session_lang: /^session_lang=([a-z]{2})$/,
    },

    # Query parameter patterns
    query: {
      # ?lang=xx
      lang_param: /[?&]lang=([a-z]{2})/,
      # ?locale=xx
      locale_param: /[?&]locale=([a-z]{2})/,
      # ?l=xx
      short_lang: /[?&]l=([a-z]{2})/,
      # ?lang=xx&region=XX
      lang_region_params: /[?&]lang=([a-z]{2})[&]region=([A-Z]{2})/,
    },

    # Header patterns
    header: {
      # Accept-Language header
      accept_language: /^([a-z]{2})(?:-[A-Z]{2})?(?:;q=([0-9.]+))?$/,
      # X-Language header
      x_language: /^([a-z]{2})(?:-[A-Z]{2})?$/,
    },

    # Domain patterns
    domain: {
      # .bg domain for Bulgarian
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

  # Language mapping from domains
  DOMAIN_LANGUAGE_MAP = {
    ".bg": 'bg',
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

  # Extract language from URL path
  def self.extract_language_from_path(path)
    return nil unless path

    # Try path_lang pattern first
    if match = path.match(LANGUAGE_PATTERNS[:url_path][:path_lang])
      return match[1]
    end

    # Try path_lang_region pattern
    if match = path.match(LANGUAGE_PATTERNS[:url_path][:path_lang_region])
      return match[1]
    end

    # Try path_region_lang pattern
    if match = path.match(LANGUAGE_PATTERNS[:url_path][:path_region_lang])
      return match[2]
    end

    nil
  end

  # Extract language from cookie
  def self.extract_language_from_cookie(cookie_value)
    return nil unless cookie_value

    # Try standard lang cookie
    if match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:lang_cookie])
      return match[1]
    end

    # Try lang with region
    if match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:lang_region_cookie])
      return match[1]
    end

    # Try Zeropoint specific cookie
    if match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:zeropoint_lang])
      return match[1]
    end

    # Try session language
    if match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:session_lang])
      return match[1]
    end

    nil
  end

  # Extract language from query parameters
  def self.extract_language_from_query(query_string)
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

  # Extract language from Accept-Language header
  def self.extract_language_from_header(accept_language)
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

    # Return highest quality language
    languages.min_by { |lang| -lang[:quality] }&.dig(:language)
  end

  # Extract language from domain
  def self.extract_language_from_domain(domain)
    return nil unless domain

    # Check for exact domain match
    DOMAIN_LANGUAGE_MAP.each do |domain_suffix, language|
      return language if domain.end_with?(domain_suffix)
    end

    # Try generic country domain pattern
    if match = domain.match(LANGUAGE_PATTERNS[:domain][:country_domain])
      return match[1]
    end

    nil
  end

  # Validate language code
  def self.valid_language?(language)
    return false unless language.is_a?(String)
    language.match?(/^[a-z]{2}$/)
  end

  # Validate language with region
  def self.valid_language_region?(language_region)
    return false unless language_region.is_a?(String)
    language_region.match?(/^[a-z]{2}-[A-Z]{2}$/)
  end

  # Build language cookie value
  def self.build_language_cookie(language, region = nil)
    if region
      "#{language}-#{region}"
    else
      language
    end
  end

  # Parse language cookie value
  def self.parse_language_cookie(cookie_value)
    return nil unless cookie_value

    if match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:lang_region_cookie])
      {
        language: match[1],
        region: match[2],
      }
    elsif match = cookie_value.match(LANGUAGE_PATTERNS[:cookie][:lang_cookie])
      {
        language: match[1],
        region: nil,
      }
    else
      nil
    end
  end

  # Get language priority from multiple sources
  def self.get_language_priority(request)
    language = nil

    # Priority order: URL path > Query param > Cookie > Header > Domain

    # 1. URL path
    language ||= extract_language_from_path(request.path)

    # 2. Query parameters
    language ||= extract_language_from_query(request.query_string)

    # 3. Cookies
    language ||= extract_language_from_cookie(request.cookies['lang'])
    language ||= extract_language_from_cookie(request.cookies['zeropoint_lang'])
    language ||= extract_language_from_cookie(request.cookies['session_lang'])

    # 4. Accept-Language header
    language ||= extract_language_from_header(request.headers['Accept-Language'])

    # 5. Domain
    language ||= extract_language_from_domain(request.host)

    # Validate and return
    valid_language?(language) ? language : nil
  end

  # Set language cookie
  def self.set_language_cookie(response, language, region = nil, options = {})
    cookie_value = build_language_cookie(language, region)

    default_options = {
      path: '/',
      secure: Rails.env.production?,
      same_site: :lax,
      expires: 1.year.from_now,
    }

    response.set_cookie('lang', default_options.merge(options).merge(value: cookie_value))
    response.set_cookie('zeropoint_lang', default_options.merge(options).merge(value: cookie_value))
  end

  # Clear language cookies
  def self.clear_language_cookies(response)
    response.delete_cookie('lang')
    response.delete_cookie('zeropoint_lang')
    response.delete_cookie('session_lang')
  end

  # Build URL with language
  def self.build_url_with_language(base_url, language, path = '')
    if path.start_with?('/')
      "#{base_url}/#{language}#{path}"
    else
      "#{base_url}/#{language}/#{path}"
    end
  end

  # Remove language from URL path
  def self.remove_language_from_path(path)
    return path unless path

    # Remove language from beginning of path
    path.sub(LANGUAGE_PATTERNS[:url_path][:path_lang], '/')
        .sub(LANGUAGE_PATTERNS[:url_path][:path_lang_region], '/')
        .sub(LANGUAGE_PATTERNS[:url_path][:path_region_lang], '/')
        .gsub(%r{^//+}, '/') # Clean up multiple slashes
  end

  # Add language to URL path
  def self.add_language_to_path(path, language)
    return "/#{language}#{path}" unless path.start_with?('/')
    "/#{language}#{path}"
  end

  # Check if URL has language prefix
  def self.url_has_language?(path)
    return false unless path
    path.match?(LANGUAGE_PATTERNS[:url_path][:path_lang]) ||
    path.match?(LANGUAGE_PATTERNS[:url_path][:path_lang_region]) ||
    path.match?(LANGUAGE_PATTERNS[:url_path][:path_region_lang])
  end

  # Get supported languages
  def self.supported_languages
    %w[en bg de fr es it pt ru ja ko zh ar tr pl nl sv da no fi cs sk hu ro hr sl et lv lt mt el cy]
  end

  # Check if language is supported
  def self.supported_language?(language)
    supported_languages.include?(language)
  end

  # Get fallback language
  def self.fallback_language
    'en'
  end

  # Get language name
  def self.language_name(language_code)
    {
      en: 'English',
      bg: 'Български',
      de: 'Deutsch',
      fr: 'Français',
      es: 'Español',
      it: 'Italiano',
      pt: 'Português',
      ru: 'Русский',
      ja: '日本語',
      ko: '한국어',
      zh: '中文',
      ar: 'العربية',
      tr: 'Türkçe',
      pl: 'Polski',
      nl: 'Nederlands',
      sv: 'Svenska',
      da: 'Dansk',
      no: 'Norsk',
      fi: 'Suomi',
      cs: 'Čeština',
      sk: 'Slovenčina',
      hu: 'Magyar',
      ro: 'Română',
      hr: 'Hrvatski',
      sl: 'Slovenščina',
      et: 'Eesti',
      lv: 'Latviešu',
      lt: 'Lietuvių',
      mt: 'Malti',
      el: 'Ελληνικά',
      cy: 'Cymraeg',
    }[language_code] || language_code
  end
end
