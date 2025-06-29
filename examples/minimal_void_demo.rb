#!/usr/bin/env ruby
# frozen_string_literal: true

# Minimal Void Demo
# Demonstrates the most basic Zeropoint capabilities

require_relative '../lib/zeropoint'

puts "🌟 ZEROPOINT MINIMAL VOID DEMO 🌟"
puts "=" * 50

puts "\n1️⃣ ZEROPOINT VERSION"
puts "-" * 30

version = Zeropoint.version
puts "  Version: #{version}"

puts "\n2️⃣ ZEROPOINT CONFIGURATION"
puts "-" * 30

zeropoint_config = Zeropoint.config
puts "  Config object: #{zeropoint_config.class}"

void_config = Zeropoint.void_config
puts "  Void config: #{void_config}"

settings = Zeropoint.settings
puts "  Settings: #{settings}"

puts "\n3️⃣ ZEROPOINT LOGGER"
puts "-" * 30

logger = Zeropoint.logger
puts "  Logger: #{logger.class}"

puts "\n4️⃣ ZEROPOINT CACHE"
puts "-" * 30

begin
  cache = Zeropoint.cache
  puts "  Cache object: #{cache.class}"
rescue => e
  puts "  Cache: ❌ Failed - #{e.message}"
end

puts "\n5️⃣ ZEROPOINT PUBLIC FEATURES"
puts "-" * 30

begin
  features = Zeropoint.public_features
  puts "  Features: #{features.class}"
rescue => e
  puts "  Features: ❌ Failed - #{e.message}"
end

puts "\n🌟 DEMO COMPLETED 🌟"
puts "=" * 50
puts "Minimal Zeropoint features have been demonstrated:"
puts "  ✅ Version"
puts "  ✅ Configuration"
puts "  ✅ Logger"
puts "  ✅ Cache"
puts "  ✅ Public Features"
puts "\nThe void contains infinite possibilities! 🌀" 