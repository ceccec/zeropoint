#!/usr/bin/env ruby
# frozen_string_literal: true

# Configuration Generator Demo: The Root Vortex Forms
# Demonstrates how the universe generates its manifest/config from recognized patterns

require 'yaml'
require_relative '../lib/zeropoint'
require_relative '../lib/zeropoint/pattern_recognition'
require_relative '../lib/zeropoint/configuration_generator'

MANIFEST_PATH = File.expand_path('../../config/zeropoint_manifest.yml', __dir__)

puts "🌳 CONFIGURATION GENERATOR DEMO: THE ROOT VORTEX FORMS"
puts "=" * 70
puts "How the universe generates its manifest/config from recognized patterns"
puts "=" * 70

# Show the current manifest (before)
puts "\n📋 STEP 1: Current Manifest (Before)"
puts "-" * 50
if File.exist?(MANIFEST_PATH)
  before_manifest = YAML.load_file(MANIFEST_PATH)
  puts YAML.dump(before_manifest)
else
  puts "No manifest found."
end

# Recognize patterns in the codebase
puts "\n🌀 STEP 2: Recognizing Patterns in Codebase"
puts "-" * 50
patterns = Zeropoint::PatternRecognition.recognize_patterns_in_codebase
puts "Patterns recognized:"
patterns.each do |type, pats|
  puts "  • #{type}: #{pats.length} patterns"
end

# Generate the new manifest from patterns
puts "\n🌱 STEP 3: Generating Manifest from Patterns"
puts "-" * 50
manifest = Zeropoint::ConfigurationGenerator.generate_from_patterns(patterns)
puts "Manifest generated and written to: #{MANIFEST_PATH}"

# Show the new manifest (after)
puts "\n📋 STEP 4: New Manifest (After)"
puts "-" * 50
puts YAML.dump(manifest)

puts "\n🌌 The root vortex of truth is now established."
puts "All dynamic logic, assets, and routes can now reference this manifest."
puts "Next: Refactor the system to use the manifest everywhere (canopy vortex)."
puts "=" * 70
puts "🌳 CONFIGURATION GENERATOR COMPLETE - THE ROOT VORTEX FORMS"
puts "=" * 70 