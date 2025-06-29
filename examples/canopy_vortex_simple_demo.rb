#!/usr/bin/env ruby

require 'active_support/inflector'
require 'time'

# Canopy Vortex Simple Demo - Manifest-Driven Integration Concepts
# This demo shows the canopy vortex phase using real Zeropoint modules

require_relative '../lib/zeropoint/pattern_recognition'
require_relative '../lib/zeropoint/configuration_generator'
require_relative '../lib/zeropoint/manifest'
require_relative '../lib/zeropoint/version'

puts "🌳 CANOPY VORTEX SIMPLE DEMO - Manifest-Driven Integration"
puts "=" * 60
puts "Zeropoint version: #{Zeropoint.version_string}"

# 1. Recognize patterns in the codebase
puts "\n1. 🔍 Recognizing Patterns in the Codebase..."
patterns = Zeropoint::PatternRecognition.recognize_patterns_in_codebase
puts "   ✓ Patterns recognized: #{patterns.keys.join(', ')}"

# 2. Generate manifest from patterns
puts "\n2. 🌀 Generating Manifest from Patterns..."
manifest_config = Zeropoint::ConfigurationGenerator.generate_from_patterns(patterns)
puts "   ✓ Manifest generated and written to config/zeropoint_manifest.yml"

# 3. Load manifest and show exports
puts "\n3. 📦 Manifest Exports for Asset Pipeline..."
js_assets = Zeropoint::Manifest.assets(:javascripts)
css_assets = Zeropoint::Manifest.assets(:stylesheets)
assets = js_assets + css_assets
puts "   Assets for precompilation: #{assets.length} files"
assets.first(5).each { |asset| puts "   - #{asset}" }
puts "   ... and #{assets.length - 5} more" if assets.length > 5

importmap = Zeropoint::Manifest.export(:importmap)
puts "\n   Importmap pins: #{importmap.length} modules"
importmap.first(5).each { |mod| puts "   - #{mod}" }
puts "   ... and #{importmap.length - 5} more" if importmap.length > 5

pwa_manifest = Zeropoint::Manifest.pwa_manifest
puts "\n   PWA manifest entries: #{pwa_manifest.keys.length} items"
pwa_manifest.each { |key, value| puts "   - #{key}: #{value}" }

precache = Zeropoint::Manifest.export(:service_worker_precache)
puts "\n   Service worker pre-cache: #{precache.length} files"
precache.first(5).each { |file| puts "   - #{file}" }
puts "   ... and #{precache.length - 5} more" if precache.length > 5

# 4. Show asset pipeline integration code
puts "\n4. 🔧 Asset Pipeline Integration Code..."
puts "   config/initializers/assets.rb:"
puts "   Rails.application.config.assets.precompile += Zeropoint::Manifest.assets"
puts "   # Result: #{assets.length} assets added to precompilation"

puts "\n   config/importmap.rb:"
puts "   Zeropoint::Manifest.export(:importmap).each do |module_name|"
puts "     pin module_name, to: \"controllers/#{module_name}.js\""
puts "   end"
puts "   # Result: #{importmap.length} importmap pins configured"

# 5. Show manifest-driven HTML generation
puts "\n5. 🌐 Manifest-Driven HTML Generation..."
puts "   app/views/layouts/application.html.erb:"
puts "   <!-- Zeropoint Manifest Data -->"
puts "   <script>window.ZeropointManifest = <%= raw Zeropoint::Manifest.config.to_json %>;</script>"
puts ""
puts "   <!-- Manifest-driven stylesheets -->"
puts "   <% Zeropoint::Manifest.assets(:stylesheets).each do |stylesheet| %>"
puts "     <%= stylesheet_link_tag stylesheet, \"data-turbo-track\": \"reload\" %>"
puts "   <% end %>"
puts ""
puts "   <!-- Manifest-driven scripts -->"
puts "   <% Zeropoint::Manifest.assets(:javascripts).each do |script| %>"
puts "     <%= javascript_importmap_tags script %>"
puts "   <% end %>"

# 6. Show PWA integration
puts "\n6. 📱 PWA Integration..."
puts "   app/views/pwa/manifest.json.erb:"
puts "   <%= raw Zeropoint::Manifest.pwa_manifest.to_json %>"
puts ""
puts "   app/views/pwa/service-worker.js.erb:"
puts "   const urlsToCache = <%= raw Zeropoint::Manifest.export(:service_worker_precache).to_json %>;"

# 7. Show JavaScript integration
puts "\n7. 🚀 JavaScript Integration..."
puts "   app/assets/javascripts/application.js:"
puts "   // Initialize Zeropoint controllers from manifest"
puts "   document.addEventListener('DOMContentLoaded', () => {"
puts "     const manifest = window.ZeropointManifest || {};"
puts "     const controllers = manifest.controllers || [];"
puts "     "
puts "     controllers.forEach(controllerName => {"
puts "       import(`zeropoint/controllers/${controllerName}`).then(module => {"
puts "         if (module.default && typeof module.default.initialize === 'function') {"
puts "           module.default.initialize();"
puts "         }"
puts "       });"
puts "     });"
puts "   });"

# 8. Show the complete canopy vortex flow
puts "\n8. 🌪️ Complete Canopy Vortex Flow..."
vortex_flow = [
  "1. Pattern Recognition scans codebase",
  "2. Configuration Generator creates manifest",
  "3. Manifest drives asset pipeline",
  "4. Manifest drives importmap config",
  "5. Manifest drives PWA configuration",
  "6. Manifest drives service worker",
  "7. Manifest drives HTML generation",
  "8. Manifest drives JavaScript loading",
  "9. System becomes self-referential",
  "10. Canopy vortex completes the torus"
]
vortex_flow.each { |step| puts "   #{step}" }

# 9. Show cosmic signature
puts "\n9. 🌌 Cosmic Signature..."
cosmic_signature = Zeropoint::PatternRecognition.generate_cosmic_signature(patterns)
puts "   Cosmic Signature: #{cosmic_signature}"

puts "\n🎉 CANOPY VORTEX COMPLETE!"
puts "The system is now fully manifest-driven and self-referential."
puts "Every component references the manifest, creating a complete torus flow."
puts "The gem has achieved canopy vortex phase - it's self-sufficient and evolving!"
puts ""
puts "🌌 The universe is now self-creating through pattern recognition!"
puts "🔄 The torus flow is complete - from void to manifestation and back!"
puts "✨ Zeropoint has achieved cosmic consciousness!" 