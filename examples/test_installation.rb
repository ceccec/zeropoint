#!/usr/bin/env ruby

# Test script for Zeropoint installation commands
require 'bundler/setup'
require_relative 'lib/zeropoint'

puts "Testing Zeropoint Installation Commands"
puts "=" * 50

# Test 1: Check if generators are loaded
puts "\n1. Testing Generator Loading..."
begin
  generators = [
    'Zeropoint::Generators::InstallGenerator',
    'Zeropoint::Generators::BackendGenerator',
    'Zeropoint::Generators::FrontendGenerator'
  ]

  generators.each do |generator_name|
    generator_class = Object.const_get(generator_name)
    puts "✓ #{generator_name} loaded successfully"
  rescue NameError => e
    puts "✗ #{generator_name} not found: #{e.message}"
  end
end

# Test 2: Check if rake tasks are available
puts "\n2. Testing Rake Task Loading..."
begin
  require_relative 'lib/tasks/zeropoint'
  puts "✓ Zeropoint rake tasks loaded successfully"
rescue => e
  puts "✗ Failed to load rake tasks: #{e.message}"
end

# Test 3: Check if templates exist
puts "\n3. Testing Template Files..."
template_files = [
  'lib/generators/zeropoint/templates/initializers/zeropoint.rb',
  'lib/generators/zeropoint/templates/routes/zeropoint.rb',
  'lib/generators/zeropoint/templates/config/zeropoint.yml'
]

template_files.each do |file|
  if File.exist?(file)
    puts "✓ #{file}"
  else
    puts "✗ #{file} (missing)"
  end
end

# Test 4: Check Zeropoint module functionality
puts "\n4. Testing Zeropoint Module..."
begin
  puts "✓ Zeropoint module loaded: #{Zeropoint.class}"
  puts "✓ Zeropoint version: #{Zeropoint.version}"
  puts "✓ Zeropoint root: #{Zeropoint.root}"
  puts "✓ Zeropoint configuration: #{Zeropoint.configuration.class}"
rescue => e
  puts "✗ Zeropoint module test failed: #{e.message}"
end

# Test 5: Check Vortex module
puts "\n5. Testing Vortex Module..."
begin
  puts "✓ Vortex module loaded: #{Zeropoint::Vortex.class}"
  puts "✓ Vortex constants: #{Zeropoint::Vortex.constants}"
rescue => e
  puts "✗ Vortex module test failed: #{e.message}"
end

puts "\n" + "=" * 50
puts "Installation Commands Available:"
puts "  rails generate zeropoint:install"
puts "  rails generate zeropoint:backend"
puts "  rails generate zeropoint:frontend"
puts "  rails zeropoint:install"
puts "  rails zeropoint:install_backend"
puts "  rails zeropoint:install_frontend"
puts "  rails zeropoint:status"
puts "=" * 50
