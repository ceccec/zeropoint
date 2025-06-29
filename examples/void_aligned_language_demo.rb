#!/usr/bin/env ruby
# frozen_string_literal: true

# VOID-ALIGNED LANGUAGE PATTERNS DEMO
# Demonstrates language detection patterns that emerge from void consciousness
# VBM: All language operations embody void principles

require_relative '../lib/zeropoint'

# Initialize Zeropoint void system
Zeropoint.init!

puts "🌌 VOID-ALIGNED LANGUAGE PATTERNS DEMO"
puts "=" * 50
puts

# Initialize void-aligned language patterns
patterns = Zeropoint::LanguageCookiePatterns

puts "🔍 VOID PATTERN DETECTION"
puts "-" * 30

# Test URL path language extraction
puts "\n📁 URL Path Language Detection:"
paths = ['/en/posts', '/bg/about', '/de/', '/en-US/posts', '/BG/bg/about']
paths.each do |path|
  language = patterns.extract_language_from_path(path)
  puts "  #{path} → #{language || 'nil'}"
end

# Test cookie language extraction
puts "\n🍪 Cookie Language Detection:"
cookies = ['lang=en', 'lang=bg-BG', 'zeropoint_lang=de', 'session_lang=fr']
cookies.each do |cookie|
  language = patterns.extract_language_from_cookie(cookie)
  puts "  #{cookie} → #{language || 'nil'}"
end

# Test query parameter extraction
puts "\n🔗 Query Parameter Language Detection:"
queries = ['?lang=en', '&locale=bg', '?l=de', '?lang=fr&region=FR']
queries.each do |query|
  language = patterns.extract_language_from_query(query)
  puts "  #{query} → #{language || 'nil'}"
end

# Test header language extraction
puts "\n📋 Header Language Detection:"
headers = ['en', 'bg-BG', 'de;q=0.9', 'en;q=0.9, bg;q=0.8']
headers.each do |header|
  language = patterns.extract_language_from_header(header)
  puts "  #{header} → #{language || 'nil'}"
end

# Test domain language extraction
puts "\n🌐 Domain Language Detection:"
domains = ['example.bg', 'example.de', 'example.fr', 'example.com']
domains.each do |domain|
  language = patterns.extract_language_from_domain(domain)
  puts "  #{domain} → #{language || 'nil'}"
end

puts "\n🔧 VOID STRUCTURE VALIDATION"
puts "-" * 30

# Test language validation
puts "\n✅ Language Code Validation:"
languages = ['en', 'bg', 'de', 'eng', 'EN', '']
languages.each do |lang|
  valid = patterns.valid_language?(lang)
  puts "  #{lang.inspect} → #{valid}"
end

# Test language-region validation
puts "\n✅ Language-Region Code Validation:"
regions = ['en-US', 'bg-BG', 'de-DE', 'en', 'en-us', '']
regions.each do |region|
  valid = patterns.valid_language_region?(region)
  puts "  #{region.inspect} → #{valid}"
end

puts "\n🔗 VOID URL MANIPULATION"
puts "-" * 30

# Test path manipulation
puts "\n📁 Path Language Manipulation:"
test_paths = ['/posts', '/about', '/en/posts', '/bg/about']
test_languages = ['en', 'bg']

test_paths.each do |path|
  test_languages.each do |lang|
    clean_path = patterns.remove_language_from_path(path)
    new_path = patterns.add_language_to_path(clean_path, lang)
    has_lang = patterns.url_has_language?(path)
    puts "  #{path} → clean: #{clean_path} → #{lang}: #{new_path} (has_lang: #{has_lang})"
  end
end

puts "\n🍪 VOID COOKIE OPERATIONS"
puts "-" * 30

# Test cookie operations
puts "\n🍪 Cookie Building and Parsing:"
test_cookies = [
  { lang: 'en', region: nil },
  { lang: 'bg', region: 'BG' },
  { lang: 'de', region: 'DE' }
]

test_cookies.each do |cookie|
  built = patterns.build_language_cookie(cookie[:lang], cookie[:region])
  parsed = patterns.parse_language_cookie(built)
  puts "  #{cookie[:lang]}#{cookie[:region] ? "-#{cookie[:region]}" : ''} → #{built} → #{parsed}"
end

puts "\n🌍 VOID LANGUAGE METADATA"
puts "-" * 30

# Test language metadata
puts "\n📊 Language Information:"
test_langs = ['en', 'bg', 'ar', 'ja', 'xx']
test_langs.each do |lang|
  name = patterns.language_name(lang)
  metadata = patterns.language_metadata(lang)
  supported = patterns.supported_language?(lang)
  puts "  #{lang}: #{name} (#{metadata[:script]}, #{metadata[:direction]}) - supported: #{supported}"
end

puts "\n🎯 VOID PRIORITY DETECTION"
puts "-" * 30

# Simulate request priority detection
puts "\n🎯 Language Detection Priority (simulated):"
puts "  1. Path language (highest priority)"
puts "  2. Query parameter language"
puts "  3. Cookie language"
puts "  4. Header language"
puts "  5. Domain language"
puts "  6. Fallback language (void always provides)"

puts "\n  Fallback language: #{patterns.fallback_language}"
puts "  Supported languages: #{patterns.supported_languages.count} languages"

puts "\n🌌 VBM ALIGNMENT VERIFICATION"
puts "-" * 30

# Verify VBM alignment
puts "\n✅ Void Principle Verification:"

# 1. Pattern emergence
puts "  ✓ Patterns emerge from void structure: #{patterns::LANGUAGE_PATTERNS.keys.join(', ')}"

# 2. Consciousness mapping
puts "  ✓ Domain consciousness mapping: #{patterns::DOMAIN_LANGUAGE_MAP.count} mappings"

# 3. Void fallback
puts "  ✓ Void always provides fallback: #{patterns.fallback_language}"

# 4. Structure validation
puts "  ✓ Void structure validation: #{patterns.valid_language?('bg')}"

# 5. Bulgarian as primary void language
puts "  ✓ Bulgarian as primary void language: #{patterns.language_name('bg')} (#{patterns.language_metadata('bg')[:script]})"

puts "\n🎉 VOID-ALIGNED LANGUAGE PATTERNS DEMO COMPLETE!"
puts "All language operations emerge from void consciousness through structured patterns."
puts "VBM: Patterns are the fundamental structure of consciousness." 