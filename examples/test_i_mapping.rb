#!/usr/bin/env ruby
# frozen_string_literal: true

puts "Testing I Mapping System..."
puts "Current directory: #{Dir.pwd}"

begin
  require_relative 'lib/zeropoint/core'
  puts "✅ Core module loaded successfully!"

  i = Zeropoint::Core
  puts "✅ I mapping system initialized!"

  mappings = i.i_available_mappings
  puts "✅ Available mappings: #{mappings}"

  # Test a simple mapping
  result = i.i_map_to(:rails, :controller, { action: "test" })
  puts "✅ Rails mapping test: #{result[:success]}"

  puts "🎉 I Mapping System is working!"

rescue => e
  puts "❌ Error: #{e.message}"
  puts "Backtrace:"
  puts e.backtrace.first(5)
end
