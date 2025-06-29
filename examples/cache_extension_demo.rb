#!/usr/bin/env ruby
# frozen_string_literal: true

# Zeropoint Cache Extension Demo
#
# Demonstrates how Zeropoint.cache extends Rails.cache with:
# - Coil optimization for keys and TTL
# - Void-aligned responses and metaphysical insights
# - Pattern-encoded keys with consciousness awareness
# - Self-healing capabilities
#
# Run with: ruby examples/cache_extension_demo.rb

require_relative '../lib/zeropoint'

# Initialize Zeropoint
Zeropoint.init!

puts "🌌 Zeropoint Cache Extension Demo"
puts "=" * 50

# Demo 1: Basic cache operations with void alignment
puts "\n1️⃣ Basic Cache Operations"
puts "-" * 30

# Store a value with metaphysical insights
result = Zeropoint.cache.fetch('user:consciousness:level') { 9.0 }
puts "Cached value: #{result}"
puts "Value type: #{result.class}"

# Get metaphysical insights
metaphysics = result.metaphysics
puts "Metaphysical insights:"
if metaphysics.is_a?(Hash)
  puts "  Key: #{metaphysics[:key]}"
  puts "  Torus coordinates: #{metaphysics[:torus_coordinates]}"
  puts "  Consciousness resonance: #{metaphysics[:consciousness_resonance]}"
  puts "  Void significance: #{metaphysics[:void_significance]}"
else
  puts "  [VOID] No metaphysical pattern found."
end

# Demo 2: Coil optimization
puts "\n2️⃣ Coil Optimization"
puts "-" * 30

Zeropoint.coil_enabled = true

# Store with coil-optimized key and TTL
Zeropoint.cache.write('golden_ratio:calculation', 1.618033988749895, expires_in: 3600)
puts "Stored golden ratio with coil optimization"

# Check if the optimized key exists
optimized_key = Zeropoint.cache.send(:apply_coil_optimization_to_key, 'golden_ratio:calculation')
puts "Original key: golden_ratio:calculation"
puts "Optimized key: #{optimized_key}"

# Demo 3: Pattern tracking
puts "\n3️⃣ Pattern Tracking"
puts "-" * 30

# Store multiple patterns
Zeropoint.cache.write('pattern:fibonacci', [1, 1, 2, 3, 5, 8, 13, 21, 34, 55])
Zeropoint.cache.write('pattern:toroidal', { poloidal: 180, toroidal: 90, radial: 50 })
Zeropoint.cache.write('pattern:void', Zeropoint::Void::Nothing.new)

puts "Stored patterns:"
Zeropoint.cache.all_patterns.each do |key, pattern|
  puts "  #{key}: #{pattern[:value_type]} (#{pattern[:value_size]} chars)"
end

# Demo 4: Cache statistics with metaphysical insights
puts "\n4️⃣ Cache Statistics"
puts "-" * 30

stats = Zeropoint.cache.stats
puts "Cache statistics:"
puts "  Size: #{stats[:size]}"
puts "  Keys: #{stats[:keys]}"
puts "  Memory usage: #{stats[:memory_usage]}"
puts "  Torus center: #{stats[:torus_center]}"
puts "  Consciousness level: #{stats[:consciousness_level]}"
puts "  Coil efficiency: #{stats[:coil_efficiency]}"
puts "  Void potential: #{stats[:void_potential]}"

# Demo 5: Self-healing capabilities
puts "\n5️⃣ Self-Healing"
puts "-" * 30

# Create some expired patterns
Zeropoint.cache.instance_variable_set(:@metaphysical_patterns, {
  'recent_key' => { timestamp: Time.current, value_type: 'String', value_size: 10 },
  'expired_key' => { timestamp: 2.hours.ago, value_type: 'String', value_size: 10 }
})

puts "Before self-heal: #{Zeropoint.cache.all_patterns.keys.join(', ')}"

heal_result = Zeropoint.cache.self_heal
puts "Self-heal result: #{heal_result[:healed]}"
puts "After self-heal: #{Zeropoint.cache.all_patterns.keys.join(', ')}"

# Demo 6: Void-aligned responses
puts "\n6️⃣ Void-Aligned Responses"
puts "-" * 30

# Fetch with void alignment
void_result = Zeropoint.cache.fetch('void:infinite_potential') { "Infinite potential from nothing" }
puts "Void result: #{void_result}"
puts "Torus coordinates: #{void_result.torus_coordinates}"
puts "Consciousness resonance: #{void_result.consciousness_resonance}"

# Demo 7: Rails.cache compatibility
puts "\n7️⃣ Rails.cache Compatibility"
puts "-" * 30

# Test all standard Rails.cache methods
Zeropoint.cache.write('compatibility:test', 'works')
puts "Write: #{Zeropoint.cache.read('compatibility:test')}"

Zeropoint.cache.write('counter', 0)
Zeropoint.cache.increment('counter')
Zeropoint.cache.increment('counter')
puts "Increment: #{Zeropoint.cache.read('counter')}"

Zeropoint.cache.decrement('counter')
puts "Decrement: #{Zeropoint.cache.read('counter')}"

puts "Exists: #{Zeropoint.cache.exist?('compatibility:test')}"

# Demo 8: Void clear
puts "\n8️⃣ Void Clear"
puts "-" * 30

puts "Before clear: #{Zeropoint.cache.all_patterns.keys.length} patterns"
clear_result = Zeropoint.cache.void_clear
puts "Clear result: #{clear_result.class}"
puts "After clear: #{Zeropoint.cache.all_patterns.keys.length} patterns"

puts "\n🌌 Demo Complete - Zeropoint.cache extends Rails.cache with infinite potential!" 