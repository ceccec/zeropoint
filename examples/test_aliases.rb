#!/usr/bin/env ruby
# frozen_string_literal: true

# Test script to verify aliases have been removed and ZEROPOINT constant is accessible

# Load the Zeropoint module
require_relative 'lib/zeropoint'

puts "Testing Zeropoint module..."

# Test if Zeropoint module exists
if defined?(Zeropoint)
  puts "✓ Zeropoint module is defined"
else
  puts "✗ Zeropoint module is not defined"
end

# Test if ZEROPOINT constant exists within Zeropoint module
if defined?(Zeropoint::ZEROPOINT)
  puts "✓ Zeropoint::ZEROPOINT constant is defined"

  # Test the ZEROPOINT constant
  zeropoint_data = Zeropoint::ZEROPOINT
  puts "✓ ZEROPOINT constant is accessible"
  puts "  Version: #{zeropoint_data[:version]}"
  puts "  Security Level: #{zeropoint_data[:security_level]}"
  puts "  Exposure Type: #{zeropoint_data[:exposure_type]}"
else
  puts "✗ Zeropoint::ZEROPOINT constant is not defined"
end

# Test that old aliases are NOT defined
aliases_to_check = %w[
  ZERO_POINT
  zeropoint
  $zeropoint
]

aliases_to_check.each do |alias_name|
  if defined?(eval(alias_name))
    puts "✗ Alias '#{alias_name}' is still defined (should be removed)"
  else
    puts "✓ Alias '#{alias_name}' is not defined (correctly removed)"
  end
end

# Test that the module is frozen
if defined?(Zeropoint::ZEROPOINT) && Zeropoint::ZEROPOINT.frozen?
  puts "✓ ZEROPOINT constant is frozen (immutable)"
else
  puts "✗ ZEROPOINT constant is not frozen"
end

puts "\nTest completed!"
