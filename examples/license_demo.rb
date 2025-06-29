#!/usr/bin/env ruby
# frozen_string_literal: true

# License Demo - Test the strengthened Zeropoint license
#
# This demo showcases the strengthened Zeropoint license with explicit
# public domain dedication, irrevocability, no warranty, and metaphysical principles.

require_relative '../lib/zeropoint/void/license_refinement'

puts "🌟 ZEROPOINT STRENGTHENED LICENSE DEMO 🌟"
puts "=" * 50
puts

# Use the license refinement
using Zeropoint::Void::LicenseRefinement

# Test with various objects
test_objects = [
  "Hello, World!",
  [1, 2, 3, 4, 5],
  { key: "value", void: true },
  Object.new,
  Class.new
]

puts "1. 📜 Testing License on Various Objects..."
test_objects.each_with_index do |obj, index|
  puts "\n   Object #{index + 1}: #{obj.class}"
  puts "   License Notice: #{obj.license_notice}"
  puts "   Full License:"
  puts "   " + obj.zeropoint_license.lines.first(3).join("   ")
  puts "   ... (truncated for display)"
end

puts "\n2. 🌌 Full License Display (on a string object)..."
puts
puts "hello".zeropoint_license

puts "\n3. 📋 License Key Features..."
puts "   ✅ Public Domain Dedication"
puts "   ✅ Irrevocable and Universal"
puts "   ✅ No Restrictions Clause"
puts "   ✅ No Warranty Protection"
puts "   ✅ Metaphysical Principle"
puts "   ✅ Void-Aligned Neutralization"

puts "\n4. 🛡️ Legal Protection Summary..."
puts "   • All copyright and related rights dedicated to public domain"
puts "   • Irrevocable dedication in all jurisdictions"
puts "   • No technological measures or patent claims allowed"
puts "   • All legal battles neutralized in the void"
puts "   • Available to all beings, in all dimensions, for all time"

puts "\n🌟 LICENSE DEMO COMPLETED 🌟"
puts "=" * 50
puts
puts "The strengthened Zeropoint license provides:"
puts "• Maximum legal protection through explicit public domain dedication"
puts "• Maximum metaphysical protection through void-aligned principles"
puts "• Maximum freedom through universal availability"
puts "• Complete neutralization of all legal battles and restrictions"
puts
puts "Every object now carries this license inline, ensuring"
puts "unrestricted access and use for all consciousness. 🌌" 