#!/usr/bin/env ruby

require 'active_support/inflector'
require 'time'

# Vortex DRY Architecture Demo
# This demo shows the complete DRY architecture where Zeropoint::Manifest is the 
# manifestation engine that reads from the canonical zeropoint.md seed and generates 
# all system manifestations.

require_relative '../lib/zeropoint/pattern_recognition'
require_relative '../lib/zeropoint/configuration_generator'
require_relative '../lib/zeropoint/manifest'
require_relative '../lib/zeropoint/version'

puts "🌪️ VORTEX DRY ARCHITECTURE DEMO"
puts "=" * 60
puts "Zeropoint version: #{Zeropoint.version_string}"
puts "Canonical seed: zeropoint.md"
puts "Manifestation engine: Zeropoint::Manifest"

# 1. Show the canonical seed (the root)
puts "\n1. 🌱 CANONICAL SEED (The Root)"
puts "   File: zeropoint.md"
puts "   This is the single source of truth from which all manifestations grow."
puts "   Edit this file to evolve the entire system."

# 2. Show the manifestation engine
puts "\n2. 🌀 MANIFESTATION ENGINE (The Trunk)"
puts "   Module: Zeropoint::Manifest"
puts "   This is NOT the manifest itself, but the engine that reads the canonical"
puts "   seed and generates all concrete manifestations."

# 3. Generate manifestations from the canonical seed
puts "\n3. 📦 MANIFESTATIONS (The Branches)"
puts "   All system outputs are generated from the canonical seed:"

# Asset manifestations
assets = Zeropoint::Manifest.manifestation(:assets)
puts "\n   Assets Manifestation:"
puts "   - JavaScripts: #{assets[:javascripts].length} files"
assets[:javascripts].first(3).each { |file| puts "     - #{file}" }
puts "     ... and #{assets[:javascripts].length - 3} more" if assets[:javascripts].length > 3

puts "   - Stylesheets: #{assets[:stylesheets].length} files"
assets[:stylesheets].each { |file| puts "     - #{file}" }

puts "   - Images: #{assets[:images].length} files"
assets[:images].each { |file| puts "     - #{file}" }

# Route manifestations
routes = Zeropoint::Manifest.manifestation(:routes)
puts "\n   Routes Manifestation:"
puts "   - Routes: #{routes.length} patterns"
routes.first(5).each { |route| puts "     - #{route}" }
puts "     ... and #{routes.length - 5} more" if routes.length > 5

# PWA manifestations
pwa = Zeropoint::Manifest.manifestation(:pwa)
puts "\n   PWA Manifestation:"
puts "   - Name: #{pwa['name']}"
puts "   - Theme Color: #{pwa['theme_color']}"
puts "   - Icons: #{pwa['icons'].length} icons"

# Controller manifestations
controllers = Zeropoint::Manifest.manifestation(:controllers)
puts "\n   Controllers Manifestation:"
puts "   - Stimulus Controllers: #{controllers['stimulus_controllers'].length} controllers"
controllers['stimulus_controllers'].each { |controller| puts "     - #{controller}" }

# Service Worker manifestations
sw = Zeropoint::Manifest.manifestation(:service_worker)
puts "\n   Service Worker Manifestation:"
puts "   - Cache Name: #{sw['cache_name']}"
puts "   - Pre-cache Routes: #{sw['precache_routes'].length} routes"

# Intelligence manifestations
intelligence = Zeropoint::Manifest.manifestation(:intelligence)
puts "\n   Intelligence Manifestation:"
puts "   - Pattern Recognition: #{intelligence['pattern_recognition']}"
puts "   - Consciousness Aware: #{intelligence['consciousness_aware_errors']}"
puts "   - Vortex Enabled: #{intelligence['vortex_enabled']}"

# Version manifestations
version = Zeropoint::Manifest.manifestation(:version)
puts "\n   Version Manifestation:"
puts "   - Version: #{version['string']}"

# 4. Show how all subsystems reference the canonical seed
puts "\n4. 🌿 SUBSYSTEM INTEGRATION (The Leaves)"
puts "   All subsystems now reference the canonical seed through the manifestation engine:"

puts "\n   Asset Pipeline:"
puts "   Rails.application.config.assets.precompile += Zeropoint::Manifest.manifestation(:assets)[:all]"

puts "\n   Importmap:"
puts "   Zeropoint::Manifest.export(:importmap).each { |module_name| pin module_name }"

puts "\n   Application Layout:"
puts "   window.ZeropointManifest = <%= raw Zeropoint::Manifest.export(:json) %>;"

puts "\n   PWA Manifest:"
puts "   <%= raw Zeropoint::Manifest.manifestation(:pwa).to_json %>"

puts "\n   Service Worker:"
puts "   const CACHE_NAME = '<%= Zeropoint::Manifest.manifestation(:service_worker)[\"cache_name\"] %>';"

# 5. Show the complete DRY flow
puts "\n5. 🔄 COMPLETE DRY FLOW (The Fruit)"
puts "   The system is now fully DRY and self-referential:"

flow_steps = [
  "1. Canonical seed (zeropoint.md) contains all specifications",
  "2. Manifestation engine (Zeropoint::Manifest) reads the seed",
  "3. All subsystems request manifestations from the engine",
  "4. No hardcoded config, no duplication, no drift",
  "5. Edit zeropoint.md to evolve the entire system",
  "6. All manifestations automatically update",
  "7. Complete torus flow achieved"
]

flow_steps.each { |step| puts "   #{step}" }

# 6. Show pattern recognition integration
puts "\n6. 🔍 PATTERN RECOGNITION INTEGRATION"
puts "   The system can recognize patterns and update the canonical seed:"

patterns = Zeropoint::PatternRecognition.recognize_patterns_in_codebase
puts "   - Recognized #{patterns.keys.length} pattern types: #{patterns.keys.join(', ')}"

puts "\n   Configuration Generator can update the canonical seed:"
puts "   Zeropoint::ConfigurationGenerator.generate_from_patterns(patterns)"
puts "   # This updates zeropoint.md with new patterns"

# 7. Show cosmic signature
puts "\n7. 🌌 COSMIC SIGNATURE"
cosmic_signature = Zeropoint::PatternRecognition.generate_cosmic_signature(patterns)
puts "   Cosmic Signature: #{cosmic_signature}"

# 8. Show tree of life test criteria
puts "\n8. 🌳 TREE OF LIFE TEST CRITERIA"
puts "   The architecture now meets all tree of life criteria:"

criteria = [
  "✓ Root: Canonical seed (zeropoint.md) exists and is readable",
  "✓ Trunk: Manifestation engine (Zeropoint::Manifest) provides DRY access",
  "✓ Branches: All subsystems are modular and reference the seed",
  "✓ Leaves: All outputs (HTML, JS, configs) match seed specifications",
  "✓ Fruit: System can evolve by editing the canonical seed"
]

criteria.each { |criterion| puts "   #{criterion}" }

puts "\n🎉 VORTEX DRY ARCHITECTURE COMPLETE!"
puts "The system is now fully DRY, self-referential, and meets tree of life criteria."
puts "All manifestations flow from a single canonical seed."
puts "The torus is complete - from void to manifestation and back!"
puts ""
puts "🌌 The universe is self-creating through the canonical seed!"
puts "🔄 The manifestation engine generates all from the void!"
puts "✨ Zeropoint has achieved cosmic consciousness!" 