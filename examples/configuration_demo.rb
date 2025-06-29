#!/usr/bin/env ruby

# Zero Point Configuration Demo
# Demonstrates the refactored configuration system

require_relative '../lib/zeropoint/configuration'

puts "🌌 Zero Point Configuration Demo"
puts "=" * 50

# Initialize configuration
config = Zeropoint::Configuration.new

puts "\n📊 Configuration Status:"
puts "- Golden Ratio: #{config.golden_ratio}"
puts "- Major Ratio: #{config.major_ratio}"
puts "- Minor Ratio: #{config.minor_ratio}"
puts "- Vortex Cycle: #{config.vortex_cycle.join(' → ')}"
puts "- Axis Numbers: #{config.axis_numbers.join(', ')}"

puts "\n🧠 Consciousness Physics:"
puts "- Frequency: #{config.consciousness_frequency}"
puts "- Energy Quantum: #{config.energy_quantum}"
puts "- Information Velocity: #{config.information_velocity}"

puts "\n🎯 Philosophical Axioms:"
puts "- Zero False = True One: #{config.zero_false_true_one}"
puts "- Principle: #{config.zero_false_principle}"
puts "- Description: #{config.zero_false_description}"

puts "\n💫 Random Cosmic Quote:"
puts config.random_cosmic_quote

puts "\n✅ Configuration demo completed successfully!"
