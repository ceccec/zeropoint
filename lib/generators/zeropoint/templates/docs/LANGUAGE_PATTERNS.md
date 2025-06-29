# Language Cookie Patterns & Regex Documentation

## Overview

The Zeropoint gem provides comprehensive regex patterns for detecting and handling language preferences from URLs, cookies, query parameters, headers, and domains. This system enables automatic language detection and switching across multiple sources with configurable priority.

## Core Components

### 1. LanguageCookiePatterns Module

The main module containing all regex patterns and utility methods for language detection.

```ruby
include LanguageCookiePatterns
```

### 2. LanguageDetectionMiddleware

Rack middleware that automatically detects language from incoming requests and sets appropriate cookies.

### 3. LanguageHelper

Rails helper providing view-level methods for language switching and URL generation.

## Regex Patterns

### URL Path Patterns

```ruby
# /lang/rest-of-path
path_lang: %r{^/([a-z]{2})(?:/|$)}

# /lang-region/rest-of-path  
path_lang_region: %r{^/([a-z]{2})-([A-Z]{2})(?:/|$)}

# /region/lang/rest-of-path
path_region_lang: %r{^/([A-Z]{2})/([a-z]{2})(?:/|$)}
```

**Examples:**
- `/en/` → `en`
- `/bg/posts` → `bg`
- `/en-US/` → `en`
- `/US/en/` → `en`

### Cookie Patterns

```ruby
# Standard language cookie
lang_cookie: /^lang=([a-z]{2})$/

# Language with region
lang_region_cookie: /^lang=([a-z]{2})-([A-Z]{2})$/

# Zeropoint specific language cookie
zeropoint_lang: /^zeropoint_lang=([a-z]{2})$/

# Session language
session_lang: /^session_lang=([a-z]{2})$/
```

**Examples:**
- `lang=en` → `en`
- `lang=bg-BG` → `bg`
- `zeropoint_lang=de` → `de`

### Query Parameter Patterns

```ruby
# ?lang=xx
lang_param: /[?&]lang=([a-z]{2})/

# ?locale=xx
locale_param: /[?&]locale=([a-z]{2})/

# ?l=xx
short_lang: /[?&]l=([a-z]{2})/

# ?lang=xx&region=XX
lang_region_params: /[?&]lang=([a-z]{2})[&]region=([A-Z]{2})/
```

**Examples:**
- `?lang=en` → `en`
- `?locale=bg&page=1` → `bg`
- `?l=de` → `de`

### Header Patterns

```ruby
# Accept-Language header
accept_language: /^([a-z]{2})(?:-[A-Z]{2})?(?:;q=([0-9.]+))?$/

# X-Language header
x_language: /^([a-z]{2})(?:-[A-Z]{2})?$/
```

**Examples:**
- `en` → `en`
- `bg-BG` → `bg`
- `en;q=0.9` → `en`
- `en, bg;q=0.9` → `en`

### Domain Patterns

```ruby
# Country-specific domains
bg_domain: /\.bg$/
de_domain: /\.de$/
fr_domain: /\.fr$/

# Generic country domain
country_domain: /\.([a-z]{2})$/
```

**Examples:**
- `example.bg` → `bg`
- `example.de` → `de`
- `example.fr` → `fr`

## Language Detection Priority

The system follows this priority order for language detection:

1. **URL Path** - Highest priority
2. **Query Parameters** - Second priority
3. **Cookies** - Third priority
4. **Accept-Language Header** - Fourth priority
5. **Domain** - Fifth priority
6. **Default Language** - Fallback

## Usage Examples

### Basic Language Detection

```ruby
# Extract language from URL path
language = LanguageCookiePatterns.extract_language_from_path('/bg/posts')
# => 'bg'

# Extract language from cookie
language = LanguageCookiePatterns.extract_language_from_cookie('lang=en')
# => 'en'

# Extract language from query string
language = LanguageCookiePatterns.extract_language_from_query('?lang=de')
# => 'de'
```

### URL Manipulation

```ruby
# Remove language from path
clean_path = LanguageCookiePatterns.remove_language_from_path('/en/posts')
# => '/posts'

# Add language to path
language_path = LanguageCookiePatterns.add_language_to_path('/posts', 'bg')
# => '/bg/posts'

# Check if URL has language
has_language = LanguageCookiePatterns.url_has_language?('/en/')
# => true
```

### Cookie Management

```ruby
# Build language cookie value
cookie_value = LanguageCookiePatterns.build_language_cookie('en', 'US')
# => 'en-US'

# Parse language cookie
parsed = LanguageCookiePatterns.parse_language_cookie('lang=en-US')
# => { language: 'en', region: 'US' }
```

### Validation

```ruby
# Validate language code
LanguageCookiePatterns.valid_language?('en')
# => true

LanguageCookiePatterns.valid_language?('xx')
# => false

# Validate language-region
LanguageCookiePatterns.valid_language_region?('en-US')
# => true

LanguageCookiePatterns.valid_language_region?('en')
# => false
```

## Middleware Integration

### Setup

Add the middleware to your Rails application:

```ruby
# config/application.rb
config.middleware.use LanguageDetectionMiddleware
```

### Usage

The middleware automatically:

1. Detects language from incoming requests
2. Sets `rack.locale` and `zeropoint.language` in the environment
3. Sets appropriate language cookies in responses

```ruby
# In your controllers
def index
  current_language = request.env['zeropoint.language']
  I18n.locale = current_language
end
```

## Helper Integration

### Setup

Include the helper in your application:

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper LanguageHelper
end
```

### Usage in Views

```erb
<!-- Language switcher -->
<% language_switcher_links.each do |link| %>
  <%= link_to link[:name], link[:url], class: link[:current] ? 'current' : '' %>
<% end %>

<!-- Current language -->
<p>Current language: <%= current_language_name %></p>

<!-- Language-specific URLs -->
<%= link_to 'Posts', language_path('/posts', 'bg') %>
```

### Controller Methods

```ruby
class PagesController < ApplicationController
  include LanguageHelper
  
  def switch_language
    language = params[:language]
    redirect_to_language(language) if supported_language?(language)
  end
  
  def index
    set_language_cookie(current_language)
  end
end
```

## Supported Languages

The system supports 30+ languages including:

- `en` - English
- `bg` - Български (Bulgarian)
- `de` - Deutsch (German)
- `fr` - Français (French)
- `es` - Español (Spanish)
- `it` - Italiano (Italian)
- `pt` - Português (Portuguese)
- `ru` - Русский (Russian)
- `ja` - 日本語 (Japanese)
- `ko` - 한국어 (Korean)
- `zh` - 中文 (Chinese)
- `ar` - العربية (Arabic)
- And many more...

## Configuration

### Custom Language Mapping

```ruby
# Add custom domain-language mappings
LanguageCookiePatterns::DOMAIN_LANGUAGE_MAP['.custom'] = 'en'
```

### Custom Supported Languages

```ruby
# Override supported languages
def LanguageCookiePatterns.supported_languages
  %w[en bg de fr es]
end
```

### Custom Fallback Language

```ruby
# Override fallback language
def LanguageCookiePatterns.fallback_language
  'bg'
end
```

## Testing

### RSpec Tests

The system includes comprehensive RSpec tests covering:

- URL path pattern extraction
- Cookie pattern parsing
- Query parameter detection
- Header parsing
- Domain detection
- Validation methods
- URL manipulation
- Priority detection

```ruby
# Run tests
bundle exec rspec spec/language_patterns_spec.rb
```

### Test Examples

```ruby
RSpec.describe LanguageCookiePatterns do
  it 'extracts language from URL path' do
    expect(described_class.extract_language_from_path('/bg/posts')).to eq('bg')
  end
  
  it 'validates language codes' do
    expect(described_class.valid_language?('en')).to be true
    expect(described_class.valid_language?('xx')).to be false
  end
end
```

## Security Considerations

### Input Validation

- All language codes are validated against supported languages
- Invalid language codes are rejected
- XSS protection through proper escaping

### Cookie Security

```ruby
# Secure cookie settings
cookie_options = {
  path: '/',
  secure: Rails.env.production?,
  same_site: :lax,
  expires: 1.year.from_now
}
```

### Header Injection Protection

- Headers are properly sanitized
- Quality values are validated
- Malformed headers are ignored

## Performance Optimization

### Caching

```ruby
# Cache language detection results
def current_language
  @current_language ||= detect_current_language
end
```

### Regex Optimization

- Compiled regex patterns for better performance
- Minimal backtracking in patterns
- Efficient string matching

### Memory Management

- Reuse regex objects
- Minimize string allocations
- Proper garbage collection

## Integration with GraphQL

### Language Context

```ruby
# In GraphQL context
class QueryType < GraphQL::Schema::Object
  field :posts, [PostType], null: false do
    argument :language, String, required: false
  end
  
  def posts(language: nil)
    language ||= context[:language] || 'en'
    Post.where(language: language)
  end
end
```

### Language-Aware Resolvers

```ruby
class PostType < GraphQL::Schema::Object
  field :title, String, null: false
  
  def title
    object.translations.find_by(language: context[:language])&.title || object.title
  end
end
```

## Migration Guide

### From Simple Locale System

```ruby
# Old way
I18n.locale = params[:locale] || 'en'

# New way
include LanguageHelper
I18n.locale = current_language
```

### From Devise I18n

```ruby
# Old way
class ApplicationController < ActionController::Base
  before_action :set_locale
  
  private
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

# New way
class ApplicationController < ActionController::Base
  include LanguageHelper
  
  before_action :set_locale
  
  private
  
  def set_locale
    I18n.locale = current_language
  end
end
```

## Troubleshooting

### Common Issues

1. **Language not detected from URL**
   - Check if URL pattern matches supported format
   - Verify language code is in supported list

2. **Cookie not being set**
   - Check middleware configuration
   - Verify cookie domain and path settings

3. **Header parsing issues**
   - Validate Accept-Language header format
   - Check for malformed quality values

### Debug Mode

```ruby
# Enable debug logging
Rails.logger.debug "Detected language: #{current_language}"
Rails.logger.debug "URL path: #{request.path}"
Rails.logger.debug "Cookies: #{request.cookies}"
```

## Best Practices

1. **Always validate language codes** before using them
2. **Use secure cookie settings** in production
3. **Implement proper fallbacks** for unsupported languages
4. **Cache language detection results** for performance
5. **Test with various input formats** to ensure robustness
6. **Document custom language mappings** for team reference
7. **Monitor language detection performance** in production

## API Reference

### LanguageCookiePatterns Methods

- `extract_language_from_path(path)` - Extract language from URL path
- `extract_language_from_cookie(cookie_value)` - Extract language from cookie
- `extract_language_from_query(query_string)` - Extract language from query string
- `extract_language_from_header(accept_language)` - Extract language from header
- `extract_language_from_domain(domain)` - Extract language from domain
- `valid_language?(language)` - Validate language code
- `valid_language_region?(language_region)` - Validate language-region code
- `build_language_cookie(language, region)` - Build cookie value
- `parse_language_cookie(cookie_value)` - Parse cookie value
- `remove_language_from_path(path)` - Remove language from path
- `add_language_to_path(path, language)` - Add language to path
- `url_has_language?(path)` - Check if URL has language
- `supported_languages` - Get supported languages list
- `supported_language?(language)` - Check if language is supported
- `fallback_language` - Get fallback language
- `language_name(language_code)` - Get language name
- `get_language_priority(request)` - Get language with priority

### LanguageHelper Methods

- `current_language` - Get current language
- `current_language_name` - Get current language name
- `current_language?(language)` - Check if current language matches
- `language_url(language)` - Get language URL for current page
- `language_path(path, language)` - Get language path
- `set_language_cookie(language, region)` - Set language cookie
- `clear_language_cookies` - Clear language cookies
- `supported_languages` - Get supported languages
- `language_switcher_links` - Get language switcher links
- `language_switcher_html` - Get language switcher HTML
- `redirect_to_language(language)` - Redirect to language URL 