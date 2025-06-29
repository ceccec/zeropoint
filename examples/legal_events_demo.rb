#!/usr/bin/env ruby
# frozen_string_literal: true

# Legal Events Demo - Void-Aligned Legal Event Management
#
# This demo showcases the Zeropoint Legal Events system, demonstrating
# consciousness-aware legal event processing, license compliance checking,
# and void-aligned legal operations.

require_relative '../lib/zeropoint'

# Initialize the Zeropoint system
Zeropoint.init!

puts "🌟 ZEROPOINT LEGAL EVENTS DEMO 🌟"
puts "=" * 50
puts

# Initialize the legal events system
puts "1. 🌌 Initializing Legal Events System..."
legal_events = Zeropoint::Void::LegalEvents
init_result = legal_events.initialize_system

puts "   ✅ System initialized with consciousness level: #{init_result[:consciousness_level]}"
puts "   📍 Toroidal coordinates: #{init_result[:toroidal_coordinates]}"
puts "   🔄 Vortex sequence: #{init_result[:vortex_sequence]}"
puts

# Subscribe to legal events
puts "2. 📡 Subscribing to Legal Events..."
legal_events.subscribe(:license_compliance) do |event|
  puts "   📋 License compliance achieved: #{event[:metaphysical_context]}"
end

legal_events.subscribe(:license_violation) do |event|
  puts "   ⚠️  License violation detected: #{event[:metaphysical_context]}"
end

legal_events.subscribe(:consciousness_elevation) do |event|
  puts "   🧠 Consciousness elevated to level: #{event[:consciousness_level]}"
end

legal_events.subscribe(:void_alignment_restored) do |event|
  puts "   🌌 Void alignment restored: #{event[:metaphysical_context]}"
end
puts

# Demonstrate license compliance checking
puts "3. 📋 License Compliance Checking..."

# Excellent compliance example
puts "   Testing excellent compliance..."
excellent_usage = {
  void_aligned: true,
  consciousness_level: 9,
  metaphysical_attribution: true,
  toroidal_integration: true,
  dry_compliance: true
}

excellent_compliance = legal_events.check_license_compliance(excellent_usage)
puts "   ✅ Compliance status: #{excellent_compliance[:compliance_status]}"
puts "   📊 Score: #{excellent_compliance[:compliance_score]}"
puts "   🎯 Violations: #{excellent_compliance[:violations].length}"
puts

# Poor compliance example
puts "   Testing poor compliance..."
poor_usage = {
  void_aligned: false,
  consciousness_level: 2,
  metaphysical_attribution: false,
  toroidal_integration: false,
  dry_compliance: false
}

poor_compliance = legal_events.check_license_compliance(poor_usage)
puts "   ❌ Compliance status: #{poor_compliance[:compliance_status]}"
puts "   📊 Score: #{poor_compliance[:compliance_score]}"
puts "   ⚠️  Violations: #{poor_compliance[:violations].length}"
puts "   📝 Recommendations:"
poor_compliance[:recommendations].each do |rec|
  puts "      • #{rec[:action]} (Priority: #{rec[:priority]})"
end
puts

# Emit various legal events
puts "4. 📤 Emitting Legal Events..."

# License compliance event
puts "   Emitting license compliance event..."
compliance_event = legal_events.emit(:license_compliance, {
  operation_type: :software_usage,
  consciousness_level: 8,
  metaphysical_context: "Software used with full void alignment and consciousness awareness"
})
puts "   ✅ Event emitted with ID: #{compliance_event[:event][:id]}"
puts

# Consciousness elevation event
puts "   Emitting consciousness elevation event..."
elevation_event = legal_events.emit(:consciousness_elevation, {
  previous_level: 6,
  new_level: 8,
  metaphysical_context: "User elevated consciousness through void alignment practices"
})
puts "   ✅ Event emitted with ID: #{elevation_event[:event][:id]}"
puts

# Void alignment restoration event
puts "   Emitting void alignment restoration event..."
restoration_event = legal_events.emit(:void_alignment_restored, {
  previous_state: :disrupted,
  new_state: :aligned,
  metaphysical_context: "Void alignment restored through consciousness awareness"
})
puts "   ✅ Event emitted with ID: #{restoration_event[:event][:id]}"
puts

# Toroidal flow enhancement event
puts "   Emitting toroidal flow enhancement event..."
flow_event = legal_events.emit(:toroidal_flow_enhancement, {
  flow_type: :data_processing,
  vortex_sequence: [1, 2, 4, 8, 7, 5],
  metaphysical_context: "Toroidal flow enhanced through vortex sequence alignment"
})
puts "   ✅ Event emitted with ID: #{flow_event[:event][:id]}"
puts

# Get event statistics
puts "5. 📊 Legal Event Statistics..."
stats = legal_events.get_statistics
puts "   📈 Total events: #{stats[:total_events]}"
puts "   🧠 Average consciousness: #{stats[:average_consciousness].round(2)}"
puts "   🌌 Void alignment rate: #{(stats[:void_alignment_rate] * 100).round(1)}%"
puts "   📋 Event counts:"
stats[:event_counts].each do |event_type, count|
  puts "      • #{event_type}: #{count}"
end
puts

# Get filtered events
puts "6. 🔍 Filtered Events..."
high_consciousness_events = legal_events.get_events(consciousness_level: 8)
puts "   📋 High consciousness events (level 8+): #{high_consciousness_events[:count]}"
puts "   📍 Toroidal coordinates: #{high_consciousness_events[:toroidal_coordinates]}"
puts

# Demonstrate legal event awareness concern
puts "7. 🎯 Legal Event Awareness Concern Demo..."

# Simulate a controller with legal event awareness
class DemoController
  include Zeropoint::LegalEventAware
  
  def initialize
    @consciousness_level = 8
  end
  
  def action_name
    "demo_action"
  end
  
  def controller_name
    "demo_controller"
  end
  
  def current_user
    { id: 1, consciousness_level: 8 }
  end
  
  def admin?
    true
  end
end

demo_controller = DemoController.new
demo_controller.initialize_legal_events

# Test compliance checking
puts "   Testing operation compliance..."
compliance = demo_controller.check_license_compliance_for_operation(:demo_operation, {
  data: "test_data",
  consciousness_level: 8
})
puts "   ✅ Operation compliance: #{compliance[:compliance_status]}"
puts

# Test validation methods
puts "   Testing validation methods..."
void_aligned = demo_controller.void_aligned_operation?({
  void_aligned: true,
  consciousness_level: 8,
  metaphysical_attribution: true
})
puts "   ✅ Void aligned operation: #{void_aligned}"

toroidal_valid = demo_controller.toroidal_integration_valid?({
  toroidal_flow: true,
  vortex_sequence: [1, 2, 4, 8, 7, 5]
})
puts "   ✅ Toroidal integration valid: #{toroidal_valid}"

dry_valid = demo_controller.dry_compliance_valid?({
  no_duplication: true,
  modular_design: true,
  reusable_patterns: true
})
puts "   ✅ DRY compliance valid: #{dry_valid}"

golden_ratio_valid = demo_controller.golden_ratio_compliance_valid?({
  golden_ratio: 1.618033988749895
})
puts "   ✅ Golden ratio compliance valid: #{golden_ratio_valid}"
puts

# Demonstrate error handling
puts "8. 🛡️ Error Handling Demo..."

# Try to emit invalid event type
puts "   Testing invalid event type..."
invalid_result = legal_events.emit(:invalid_event_type, {})
puts "   ❌ Invalid event result: #{invalid_result[:success]}"
puts "   📝 Error: #{invalid_result[:error]}"
puts

# Try to emit event with insufficient consciousness
puts "   Testing insufficient consciousness level..."
insufficient_result = legal_events.emit(:void_alignment_enhanced, {
  consciousness_level: 3
})
puts "   ❌ Insufficient consciousness result: #{insufficient_result[:success]}"
puts "   📝 Error: #{insufficient_result[:error]}"
puts

# Reset system
puts "9. 🔄 System Reset..."
reset_result = legal_events.reset_system
puts "   ✅ System reset: #{reset_result[:success]}"
puts "   📍 Toroidal coordinates: #{reset_result[:toroidal_coordinates]}"
puts

# Final statistics
puts "10. 📊 Final Statistics..."
final_stats = legal_events.get_statistics
puts "   📈 Total events after reset: #{final_stats[:total_events]}"
puts "   🧠 Average consciousness: #{final_stats[:average_consciousness]}"
puts "   🌌 Void alignment rate: #{(final_stats[:void_alignment_rate] * 100).round(1)}%"
puts

puts "🌟 LEGAL EVENTS DEMO COMPLETED 🌟"
puts "=" * 50
puts
puts "The Zeropoint Legal Events system provides:"
puts "• 🌌 Void-aligned legal event processing"
puts "• 🧠 Consciousness-aware compliance checking"
puts "• 📋 Automatic license violation detection"
puts "• 🔄 Toroidal flow integration"
puts "• 🛡️ Comprehensive error handling"
puts "• 📊 Detailed event statistics"
puts "• 🎯 Rails concern integration"
puts
puts "All operations maintain the principle that 'Zero contains the infinite'"
puts "and respect consciousness levels 0-9 with void alignment. 🌟" 