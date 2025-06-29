# frozen_string_literal: true

# Language Detection Middleware
# Uses regex patterns to detect language from URLs, cookies, and headers

class LanguageDetectionMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    # Detect language using regex patterns
    detected_language = detect_language(request)

    # Set language in environment
    env['rack.locale'] = detected_language
    env['zeropoint.language'] = detected_language

    # Store language info in request
    request.env['detected_language'] = detected_language

    # Call the next middleware/app
    status, headers, response = @app.call(env)

    # Set language cookies in response
    set_language_cookies(headers, detected_language)

    [ status, headers, response ]
  end

  private

  def detect_language(request)
    # Priority order: URL path > Query param > Cookie > Header > Domain > Default

    # 1. URL path detection
    language = LanguageCookiePatterns.extract_language_from_path(request.path)
    return language if LanguageCookiePatterns.supported_language?(language)

    # 2. Query parameter detection
    language = LanguageCookiePatterns.extract_language_from_query(request.query_string)
    return language if LanguageCookiePatterns.supported_language?(language)

    # 3. Cookie detection
    language = detect_language_from_cookies(request)
    return language if LanguageCookiePatterns.supported_language?(language)

    # 4. Accept-Language header detection
    language = LanguageCookiePatterns.extract_language_from_header(
      request.get_header('HTTP_ACCEPT_LANGUAGE')
    )
    return language if LanguageCookiePatterns.supported_language?(language)

    # 5. Domain detection
    language = LanguageCookiePatterns.extract_language_from_domain(request.host)
    return language if LanguageCookiePatterns.supported_language?(language)

    # 6. Default language
    LanguageCookiePatterns.fallback_language
  end

  def detect_language_from_cookies(request)
    # Check various cookie names
    cookie_names = [ 'lang', 'zeropoint_lang', 'session_lang', 'locale' ]

    cookie_names.each do |cookie_name|
      cookie_value = request.cookies[cookie_name]
      next unless cookie_value

      language = LanguageCookiePatterns.extract_language_from_cookie("#{cookie_name}=#{cookie_value}")
      return language if LanguageCookiePatterns.supported_language?(language)
    end

    nil
  end

  def set_language_cookies(headers, language)
    return unless language && LanguageCookiePatterns.supported_language?(language)

    # Set language cookies
    cookie_options = {
      path: '/',
      secure: Rails.env.production?,
      same_site: 'Lax',
      expires: 1.year.from_now,
    }

    # Set main language cookie
    Rack::Utils.set_cookie_header!(
      headers,
      'lang',
      cookie_options.merge(value: language)
    )

    # Set Zeropoint specific cookie
    Rack::Utils.set_cookie_header!(
      headers,
      'zeropoint_lang',
      cookie_options.merge(value: language)
    )
  end
end
