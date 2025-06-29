#!/usr/bin/env ruby
# frozen_string_literal: true

# Simple test script to verify Zeropoint aliases work correctly

puts "Testing Zeropoint alias system (simple version)..."
puts "=" * 50

# Define a simple Zeropoint module for testing
module Zeropoint
  VERSION = "0.1.0"

  def self.version
    VERSION
  end

  def self.test_method
    "Hello from Zeropoint!"
  end
end

# Load the comprehensive alias system
require_relative 'lib/zeropoint/aliases'

puts "✓ Main module defined: #{Zeropoint.class}"

# Test all naming variations
test_variations = [
  :Zeropoint,
  :zeropoint,
  :zeropoint,
  :zeropoint_kebab,
  :zeropoint_dash,
  :zeropoint_dot,
  :zeropoint_dotted,
  :zp,
  :zero_p
]

puts "\nTesting local variable aliases:"
test_variations.each do |var_name|
  begin
    var_value = eval(var_name.to_s)
    if var_value == Zeropoint
      puts "✓ #{var_name} = Zeropoint"
    else
      puts "✗ #{var_name} != Zeropoint (got: #{var_value.class})"
    end
  rescue NameError => e
    puts "✗ #{var_name} not defined: #{e.message}"
  end
end

# Test global constants
puts "\nTesting global constants:"
global_constants = [
  :ZERO_POINT,
  :ZEROPOINT,
  :ZERO_POINT_DASH,
  :ZERO_POINT_DOT,
  :ZERO_POINT_KEBAB,
  :ZERO_POINT_DOTTED,
  :ZP,
  :ZERO_P
]

global_constants.each do |const_name|
  begin
    const_value = Object.const_get(const_name)
    if const_value == Zeropoint
      puts "✓ #{const_name} = Zeropoint"
    else
      puts "✗ #{const_name} != Zeropoint (got: #{const_value.class})"
    end
  rescue NameError => e
    puts "✗ #{const_name} not defined: #{e.message}"
  end
end

# Test global variables
puts "\nTesting global variables:"
global_vars = [
  :$zeropoint,
  :$zeropoint,
  :$zeropoint_dash,
  :$zeropoint_dot,
  :$zeropoint_kebab,
  :$zeropoint_dotted,
  :$zp,
  :$zero_p
]

global_vars.each do |var_name|
  var_value = eval(var_name.to_s)
  if var_value == Zeropoint
    puts "✓ #{var_name} = Zeropoint"
  else
    puts "✗ #{var_name} != Zeropoint (got: #{var_value.class})"
  end
end

# Test method calls on aliases
puts "\nTesting method calls on aliases:"
begin
  version_from_main = Zeropoint.version
  version_from_alias = zeropoint.version
  version_from_global = $zeropoint.version

  if version_from_main == version_from_alias && version_from_alias == version_from_global
    puts "✓ Method calls work on all aliases: #{version_from_main}"
  else
    puts "✗ Method calls return different values"
  end
rescue => e
  puts "✗ Method call test failed: #{e.message}"
end

puts "\n" + "=" * 50
puts "Simple alias system test completed!"
