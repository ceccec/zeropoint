#!/usr/bin/env ruby
# frozen_string_literal: true

# Unified Math Naming Demo
# Demonstrates the DRY naming pattern across all math submodules

require_relative '../lib/zeropoint'
require_relative '../lib/zeropoint/math'

puts "🌌 ZeroPoint Unified Math Naming Demo"
puts "=" * 50

# Test the main Zeropoint::Math module
puts "\n📊 Zeropoint::Math Unified Interface"
puts "-" * 30
puts "Standard math methods:"
puts "  sqrt(16) = #{Zeropoint::Math.sqrt(16)}"
puts "  sin(π/2) = #{Zeropoint::Math.sin(Zeropoint::Math.pi/2)}"
puts "  cos(0) = #{Zeropoint::Math.cos(0)}"
puts "  exp(1) = #{Zeropoint::Math.exp(1)}"
puts "  log(e) = #{Zeropoint::Math.log(Zeropoint::Math.e)}"

puts "\nHigh-level constants:"
puts "  golden_ratio = #{Zeropoint::Math.golden_ratio}"
puts "  pi = #{Zeropoint::Math.pi}"
puts "  e = #{Zeropoint::Math.e}"

puts "\nDRY aliases (unified):"
puts "  dr(137) = #{Zeropoint::Math.dr(137)}"
puts "  doubling(5) = #{Zeropoint::Math.doubling(5)}"
puts "  axis(6) = #{Zeropoint::Math.axis(6)}"
puts "  fib(10) = #{Zeropoint::Math.fib(10)}"
puts "  phi = #{Zeropoint::Math.phi}"
puts "  golden_angle_n(2) = #{Zeropoint::Math.golden_angle_n(2)}"
puts "  harmonic_of(432, 3) = #{Zeropoint::Math.harmonic_of(432, 3)}"
puts "  phase_of(2) = #{Zeropoint::Math.phase_of(2)}"
puts "  is_prime?(13) = #{Zeropoint::Math.is_prime?(13)}"
puts "  primes_list(5) = #{Zeropoint::Math.primes_list(5)}"

# Test unique, domain-specific methods from submodules
puts "\n🔄 Torus-specific (not aliased):"
torus = Zeropoint::Math::Vortex::Torus
puts "  toroidal_coordinates(3) = #{torus.toroidal_coordinates(3)}"
puts "  flow_direction([1,2,4,8,7,5]) = #{torus.flow_direction([1,2,4,8,7,5])}"

puts "\n🌟 GoldenRatio-specific (not aliased):"
golden = Zeropoint::Math::Vortex::GoldenRatio
puts "  golden_rectangle(100) = #{golden.golden_rectangle(100)}"
puts "  golden_spiral_radius(90) = #{golden.golden_spiral_radius(90)}"

# Test Ruby's Math module fallback
puts "\n🔗 Ruby Math Module Fallback Test"
puts "-" * 30
puts "  Math.sqrt(25) = #{Math.sqrt(25)}"
puts "  Math.sin(Math::PI/2) = #{Math.sin(Math::PI/2)}"
# Note: Math.golden_ratio doesn't work (no monkey-patch to prevent recursion)

# Test error handling for missing methods
puts "\n⚠️ Error Handling Test"
puts "-" * 30
begin
  result = Math.nonexistent_method(42)
  puts "Unexpected: nonexistent_method returned #{result}"
rescue NoMethodError => e
  puts "Expected error: #{e.message}"
end

puts "\n✅ Demo completed successfully!"
puts "The unified naming pattern provides:"
puts "  • Consistent access to standard math methods"
puts "  • Domain-specific aliases for convenience"
puts "  • DRY delegation to avoid code duplication"
puts "  • Fallback support for Ruby's Math module" 