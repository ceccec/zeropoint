# frozen_string_literal: true

# Language Helper
# Provides methods for working with language URLs and cookies

module LanguageHelper
  include LanguageCookiePatterns

  # Get current language
  def current_language
    @current_language ||= detect_current_language
  end

  # Get current language name
  def current_language_name
    LanguageCookiePatterns.language_name(current_language)
  end

  # Check if current language is the specified language
  def current_language?(language)
    current_language == language
  end

  # Get language URL for current page
  def language_url(language)
    return current_url unless LanguageCookiePatterns.supported_language?(language)

    current_path = request.path
    current_query = request.query_string.present? ? "?#{request.query_string}" : ''

    # Remove existing language from path
    clean_path = LanguageCookiePatterns.remove_language_from_path(current_path)

    # Add new language to path
    new_path = LanguageCookiePatterns.add_language_to_path(clean_path, language)

    "#{request.base_url}#{new_path}#{current_query}"
  end

  # Get language URL for specific path
  def language_path(path, language)
    return path unless LanguageCookiePatterns.supported_language?(language)

    # Remove existing language from path
    clean_path = LanguageCookiePatterns.remove_language_from_path(path)

    # Add new language to path
    LanguageCookiePatterns.add_language_to_path(clean_path, language)
  end

  # Get language URL for specific route
  def language_route(route_name, language, options = {})
    return send(route_name, options) unless LanguageCookiePatterns.supported_language?(language)

    # Get the route path
    route_path = send(route_name, options)

    # Add language to the path
    language_path(route_path, language)
  end

  # Set language cookie
  def set_language_cookie(language, region = nil)
    return unless LanguageCookiePatterns.supported_language?(language)

    cookie_value = LanguageCookiePatterns.build_language_cookie(language, region)

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

  # Clear language cookies
  def clear_language_cookies
    cookies.delete(:lang)
    cookies.delete(:zeropoint_lang)
    cookies.delete(:session_lang)
  end

  # Get supported languages
  delegate :supported_languages, to: :LanguageCookiePatterns

  # Get language options for select
  def language_options(selected_language = nil)
    selected_language ||= current_language

    supported_languages.map do |language|
      [
        LanguageCookiePatterns.language_name(language),
        language,
        { selected: language == selected_language },
      ]
    end
  end

  # Language switcher links
  def language_switcher_links
    supported_languages.map do |language|
      {
        language: language,
        name: LanguageCookiePatterns.language_name(language),
        url: language_url(language),
        current: current_language?(language),
      }
    end
  end

  # Language switcher HTML
  def language_switcher_html
    links = language_switcher_links

    html = '<div class="language-switcher">'
    html += '<ul>'

    links.each do |link|
      css_class = link[:current] ? 'current' : ''
      html += "<li class=\"#{css_class}\">"
      html += link_to(link[:name], link[:url], class: css_class)
      html += '</li>'
    end

    html += '</ul>'
    html += '</div>'

    # Safe to use html_safe here as the content is controlled and sanitized
    # This is a template helper that generates safe HTML content from trusted data
    # The HTML is built from language names and URLs that are validated and sanitized
    # No user input is directly embedded in the generated HTML
    # rubocop:disable Rails/OutputSafety
    html.html_safe
    # rubocop:enable Rails/OutputSafety
  end

  # Get language from URL
  def language_from_url(url)
    uri = URI.parse(url)
    LanguageCookiePatterns.extract_language_from_path(uri.path)
  end

  # Check if URL has language prefix
  def url_has_language?(url)
    uri = URI.parse(url)
    LanguageCookiePatterns.url_has_language?(uri.path)
  end

  # Get language from domain
  def language_from_domain(domain = nil)
    domain ||= request.host
    LanguageCookiePatterns.extract_language_from_domain(domain)
  end

  # Get language from cookie
  def language_from_cookie(cookie_name = 'lang')
    cookie_value = cookies[cookie_name]
    return nil unless cookie_value

    LanguageCookiePatterns.extract_language_from_cookie("#{cookie_name}=#{cookie_value}")
  end

  # Get language from Accept-Language header
  def language_from_header
    LanguageCookiePatterns.extract_language_from_header(
      request.headers['Accept-Language']
    )
  end

  # Detect current language from multiple sources
  def detect_current_language
    # Priority order: URL path > Cookie > Header > Domain > Default

    # 1. URL path
    language = LanguageCookiePatterns.extract_language_from_path(request.path)
    return language if LanguageCookiePatterns.supported_language?(language)

    # 2. Cookie
    language = language_from_cookie('lang')
    return language if LanguageCookiePatterns.supported_language?(language)

    language = language_from_cookie('zeropoint_lang')
    return language if LanguageCookiePatterns.supported_language?(language)

    # 3. Header
    language = language_from_header
    return language if LanguageCookiePatterns.supported_language?(language)

    # 4. Domain
    language = language_from_domain
    return language if LanguageCookiePatterns.supported_language?(language)

    # 5. Default
    LanguageCookiePatterns.fallback_language
  end

  # Redirect to language URL
  def redirect_to_language(language)
    return unless LanguageCookiePatterns.supported_language?(language)

    # Set language cookie
    set_language_cookie(language)

    # Redirect to language URL
    redirect_to language_url(language)
  end

  # Language-aware link_to
  def language_link_to(name, options = {}, html_options = {})
    language = html_options.delete(:language) || current_language

    if options.is_a?(String)
      url = language_path(options, language)
    else
      url = language_route(name, language, options)
    end

    link_to(name, url, html_options)
  end

  # Language-aware form_for
  def language_form_for(record, options = {}, &block)
    language = options.delete(:language) || current_language

    # Add language to form action
    if options[:url].is_a?(String)
      options[:url] = language_path(options[:url], language)
    end

    form_for(record, options, &block)
  end

  # Language-aware form_with
  def language_form_with(options = {}, &block)
    language = options.delete(:language) || current_language

    # Add language to form action
    if options[:url].is_a?(String)
      options[:url] = language_path(options[:url], language)
    end

    form_with(options, &block)
  end

  # Get language-specific asset path
  def language_asset_path(asset_name)
    language = current_language

    # Try language-specific asset first
    language_asset = "#{language}/#{asset_name}"
    if asset_exists?(language_asset)
      return asset_path(language_asset)
    end

    # Fall back to default asset
    asset_path(asset_name)
  end

  # Get language-specific image path
  def language_image_path(image_name)
    language_asset_path("images/#{image_name}")
  end

  # Get language-specific stylesheet path
  def language_stylesheet_path(stylesheet_name)
    language_asset_path("stylesheets/#{stylesheet_name}")
  end

  # Get language-specific javascript path
  def language_javascript_path(javascript_name)
    language_asset_path("javascripts/#{javascript_name}")
  end

  # Language-specific content block
  def language_content(language = nil, &block)
    language ||= current_language

    if current_language?(language)
      capture(&block)
    else
      ''
    end
  end

  # Language-specific translation
  def language_t(key, language = nil, options = {})
    language ||= current_language

    I18n.with_locale(language) do
      t(key, options)
    end
  end

  # Language-specific number formatting
  def language_number_to_currency(number, language = nil, options = {})
    language ||= current_language

    I18n.with_locale(language) do
      number_to_currency(number, options)
    end
  end

  # Language-specific date formatting
  def language_l(date, language = nil, options = {})
    language ||= current_language

    I18n.with_locale(language) do
      l(date, options)
    end
  end

  private

  def asset_exists?(asset_name)
    Rails.application.assets.find_asset(asset_name).present?
  rescue StandardError
    false
  end
end
