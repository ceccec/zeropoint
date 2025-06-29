#!/usr/bin/env ruby
# frozen_string_literal: true

# Zeropoint::Manifest Demo
# Demonstrates the DRY manifest system for asset discovery, PWA generation, and exports

require_relative '../lib/zeropoint'
require_relative '../lib/zeropoint/manifest'

puts "🌌 ZEROPOINT::MANIFEST DEMO"
puts "=" * 60
puts "DRY Manifest Engine - Single Source of Truth"
puts "=" * 60

# Initialize the manifest system
puts "\n📁 STEP 1: Loading Configuration"
puts "-" * 40
puts "Config file: #{Zeropoint::Manifest::CONFIG_PATH}"
puts "Configuration loaded: #{Zeropoint::Manifest.config.keys.join(', ')}"

puts "\n🔍 STEP 2: Asset Discovery"
puts "-" * 40

# Discover all assets
all_assets = Zeropoint::Manifest.assets
puts "Total assets discovered: #{all_assets.length}"

# Discover assets by type
javascripts = Zeropoint::Manifest.assets(:javascripts)
stylesheets = Zeropoint::Manifest.assets(:stylesheets)
images = Zeropoint::Manifest.assets(:images)

puts "JavaScripts: #{javascripts.length} files"
javascripts.each { |file| puts "  📄 #{file}" }

puts "\nStylesheets: #{stylesheets.length} files"
stylesheets.each { |file| puts "  📄 #{file}" }

puts "\nImages: #{images.length} files"
images.each { |file| puts "  📄 #{file}" }

puts "\n📱 STEP 3: PWA Manifest Generation"
puts "-" * 40

pwa_manifest = Zeropoint::Manifest.pwa_manifest
puts "PWA Manifest:"
puts "  Name: #{pwa_manifest['name']}"
puts "  Short Name: #{pwa_manifest['short_name']}"
puts "  Theme Color: #{pwa_manifest['theme_color']}"
puts "  Display: #{pwa_manifest['display']}"
puts "  Icons: #{pwa_manifest['icons'].length} icons"

pwa_manifest['icons'].each_with_index do |icon, index|
  puts "    Icon #{index + 1}: #{icon['src']} (#{icon['sizes']})"
end

puts "\n🛣️ STEP 4: Route Discovery"
puts "-" * 40

routes = Zeropoint::Manifest.routes
puts "Routes discovered: #{routes.length}"
routes.each { |route| puts "  🛣️ #{route}" }

puts "\n📤 STEP 5: Export Targets"
puts "-" * 40

# Export for importmap
importmap_modules = Zeropoint::Manifest.export(:importmap)
puts "Importmap modules: #{importmap_modules.length}"
importmap_modules.each { |module_name| puts "  📦 #{module_name}" }

# Export for service worker pre-cache
precache_urls = Zeropoint::Manifest.export(:service_worker_precache)
puts "\nService Worker pre-cache URLs: #{precache_urls.length}"
precache_urls.first(5).each { |url| puts "  🔄 #{url}" }
puts "  ... and #{precache_urls.length - 5} more URLs"

# Export PWA manifest
pwa_export = Zeropoint::Manifest.export(:pwa_manifest)
puts "\nPWA Manifest export: #{pwa_export.keys.length} properties"

puts "\n🔗 STEP 6: Integration Examples"
puts "-" * 40

# Example: Generate PWA manifest JSON
puts "PWA Manifest JSON:"
json_manifest = pwa_manifest.to_json
puts json_manifest[0..100] + "..." if json_manifest.length > 100

# Example: Generate importmap configuration
puts "\nImportmap configuration:"
importmap_config = importmap_modules.map { |name| "pin \"#{name}\", to: \"controllers/#{name}.js\"" }
importmap_config.each { |config| puts "  #{config}" }

# Example: Generate service worker pre-cache list
puts "\nService Worker pre-cache list:"
puts "const PRECACHE_URLS = #{precache_urls.to_json.html_safe};"

puts "\n🌌 STEP 7: Self-Evolving Behavior"
puts "-" * 40

puts "The manifest system automatically:"
puts "  ✅ Discovers new files matching patterns"
puts "  ✅ Updates PWA manifest when config changes"
puts "  ✅ Regenerates service worker cache lists"
puts "  ✅ Updates importmap entries"
puts "  ✅ Maintains DRY principle - change once, update everywhere"

puts "\n🎯 STEP 8: DRY Benefits"
puts "-" * 40

puts "Before Zeropoint::Manifest:"
puts "  ❌ Duplicate asset lists in multiple files"
puts "  ❌ Manual PWA manifest updates"
puts "  ❌ Hardcoded service worker cache lists"
puts "  ❌ Separate importmap configuration"
puts "  ❌ Inconsistent asset management"

puts "\nAfter Zeropoint::Manifest:"
puts "  ✅ Single source of truth in config/zeropoint_manifest.yml"
puts "  ✅ Automatic PWA manifest generation"
puts "  ✅ Dynamic service worker pre-cache lists"
puts "  ✅ Automated importmap configuration"
puts "  ✅ Consistent, self-evolving asset management"

puts "\n🚀 STEP 9: Usage in Rails Application"
puts "-" * 40

puts "In your Rails views:"
puts "  # PWA manifest (app/views/pwa/manifest.json.erb)"
puts "  <%= Zeropoint::Manifest.pwa_manifest.to_json.html_safe %>"

puts "\n  # Service worker (app/views/pwa/service-worker.js.erb)"
puts "  const PRECACHE_URLS = <%= Zeropoint::Manifest.export(:service_worker_precache).to_json.html_safe %>;"

puts "\n  # Importmap (config/importmap.rb)"
puts "  Zeropoint::Manifest.export(:importmap).each do |module_name|"
puts "    pin module_name, to: \"controllers/#{module_name}.js\""
puts "  end"

puts "\n  # Asset precompilation (config/initializers/assets.rb)"
puts "  Rails.application.config.assets.precompile += Zeropoint::Manifest.assets"

puts "\n🌪️ STEP 10: Vortex Integration"
puts "-" * 40

puts "The Manifest is the canopy vortex that:"
puts "  🌳 Expresses root patterns (config, language) as accessible assets"
puts "  🔄 Streams data to PWA, service worker, and importmap"
puts "  🎯 Maintains harmony across all systems"
puts "  🚀 Enables self-evolving, universe-generating applications"

puts "\n" + "=" * 60
puts "🌌 ZEROPOINT::MANIFEST - DRY, Self-Evolving, Universe-Generating"
puts "=" * 60
puts "The manifest system ensures your application's universe is always"
puts "discoverable, cacheable, and in harmony, with zero duplication."
puts "=" * 60 