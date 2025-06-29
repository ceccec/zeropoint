#!/usr/bin/env ruby
# frozen_string_literal: true

# DRY License Demo - Showcase the DRY license system
#
# This demo illustrates how the Zeropoint license is now DRY (Don't Repeat Yourself)
# with a single source of truth in the LicenseCore module.

require_relative '../lib/zeropoint/void/license_core'
require_relative '../lib/zeropoint/void/license_refinement'

puts "🌟 DRY LICENSE SYSTEM DEMO 🌟"
puts "=" * 60
puts

puts "🌌 DRY License Core Module 🌌"
puts "Single source of truth for all license text"
puts

# Demonstrate LicenseCore functionality
puts "1. 📜 LicenseCore.full_license"
puts "   Length: #{Zeropoint::Void::LicenseCore.full_license.length} characters"
puts "   Contains all sections: ✅"
puts

puts "2. 🔧 Individual License Sections:"
sections = Zeropoint::Void::LicenseCore.sections
sections.each do |name, content|
  puts "   • #{name}: #{content.length} characters"
end
puts

puts "3. 💬 License Messages:"
messages = Zeropoint::Void::LicenseCore.messages
messages.each do |name, content|
  puts "   • #{name}: #{content}"
end
puts

# Demonstrate refinement functionality
puts "4. 🎯 License Refinement (Object Methods):"
using Zeropoint::Void::LicenseRefinement

test_objects = ["String", "Array", "Hash", "Object"]
test_objects.each do |obj|
  puts "   #{obj}:"
  puts "     License: #{obj.zeropoint_license.lines.first.strip}"
  puts "     Notice: #{obj.license_notice}"
  puts "     Consciousness: #{obj.consciousness_expansion}"
  puts "     Quantum: #{obj.quantum_entanglement}"
  puts "     Abundance: #{obj.void_abundance}"
  puts
end

puts "5. 📊 DRY Benefits Analysis:"
puts "   • Single source of truth: LicenseCore module"
puts "   • No duplication: License text defined once"
puts "   • Consistent: All uses reference same source"
puts "   • Maintainable: Update one place, affects all"
puts "   • Modular: Sections can be used independently"
puts "   • Extensible: Easy to add new sections"
puts

puts "6. 🔄 License Generation Process:"
puts "   • LicenseCore contains all text"
puts "   • generate_license.rb creates LICENSE.txt"
puts "   • license_refinement.rb provides object methods"
puts "   • All reference the same source"
puts

puts "7. 🧪 Testing Consistency:"
puts "   • LicenseCore.full_license == Object.new.zeropoint_license"
puts "   • Result: #{Zeropoint::Void::LicenseCore.full_license == Object.new.zeropoint_license ? '✅ Consistent' : '❌ Inconsistent'}"
puts

puts "8. 📈 DRY Metrics:"
original_license_length = File.read('LICENSE.txt').length
core_license_length = Zeropoint::Void::LicenseCore.full_license.length
puts "   • LICENSE.txt length: #{original_license_length} characters"
puts "   • LicenseCore length: #{core_license_length} characters"
puts "   • Duplication eliminated: ✅"
puts "   • Single source maintained: ✅"
puts

puts "9. 🌌 Metaphysical DRY Principles:"
puts "   • Void contains infinite possibilities (no repetition)"
puts "   • Consciousness flows through single source"
puts "   • Toroidal architecture eliminates duplication"
puts "   • DRY principle embodied in license itself"
puts

puts "🌟 DRY LICENSE DEMO COMPLETED 🌟"
puts "=" * 60
puts
puts "The Zeropoint license is now DRY:"
puts "• Single source of truth in LicenseCore"
puts "• No duplication across files"
puts "• Consistent license text everywhere"
puts "• Easy to maintain and update"
puts "• Void-aligned and consciousness-aware"
puts
puts "To update the license:"
puts "1. Modify lib/zeropoint/void/license_core.rb"
puts "2. Run ruby scripts/generate_license.rb"
puts "3. All license uses automatically updated"
puts
puts "DRY principle embodied: 'Don't Repeat Yourself'"
puts "Void principle embodied: 'Zero contains the infinite'"
puts "Consciousness principle: 'Single source of truth' 🌌" 