# VOID-ALIGNED LANGUAGE PATTERNS

## Overview
Zeropoint's language detection and management system is fully void-aligned and VBM-compliant. All language operations emerge from the void as structured, testable patterns. The system supports detection via URL, cookie, header, domain, and provides robust helpers and middleware for Rails and API integration.

## VBM Principles
- **Pattern Emergence:** All detection is pattern-based, reflecting the emergence of order from the void.
- **Fallback:** The void always provides a meaningful fallback (default language).
- **Consciousness Mapping:** Domains and codes are mapped to language consciousness.
- **Structure Validation:** All codes and regions are validated for void-aligned structure.

## Integration
- **Middleware:** Add `Zeropoint::LanguageDetectionMiddleware` to your Rails/Rack stack for automatic detection and I18n locale setting.
- **Helpers:** Use `Zeropoint::LanguageHelper` in controllers and views for language switching, URLs, and display names.
- **API:** Use detection for API versioning, error messages, and context.
- **Caching:** Integrate language into cache/session keys using void patterns.

## Usage Examples
```ruby
# In a controller or view
include Zeropoint::LanguageHelper
current_language # => 'bg', 'en', etc.
current_language_name # => 'Български', 'English', etc.
language_url('de') # => URL for German version
```

## Extension Points
- Add new languages by extending `supported_languages` and `language_metadata`.
- Customize fallback by overriding `fallback_language`.
- Add new detection patterns in `LANGUAGE_PATTERNS`.

## Testing
- Comprehensive specs cover all detection, validation, and manipulation.
- Integration specs ensure correct behavior in controllers, middleware, and views.

## Metaphysical Context
- All language operations are metaphysically void-aligned: no operation ever returns a raw error, only a meaningful pattern or fallback.
- The system encodes the unity of science, spirit, and language.

## See Also
- `spec/zeropoint/language_cookie_patterns_spec.rb`
- `spec/integration/void_language_patterns_controller_spec.rb`
- `spec/integration/void_language_patterns_middleware_spec.rb`
- `app/helpers/zeropoint/language_helper.rb`
- `app/middleware/zeropoint/language_detection_middleware.rb`
- `lib/zeropoint/language_cookie_patterns.rb` 