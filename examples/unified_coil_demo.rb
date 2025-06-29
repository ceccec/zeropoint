#!/usr/bin/env ruby
# frozen_string_literal: true

# Unified Coil Demo: Showcase the Zeropoint::Coil namespace
# Demonstrates Rodin, Toroidal, and Regular coils with their capabilities
# Follows DRY principles and toroidal architecture

require_relative '../lib/zeropoint'

puts "=" * 80
puts "ZEROPOINT UNIFIED COIL DEMONSTRATION"
puts "=" * 80
puts

# Initialize Zeropoint
Zeropoint.init!

puts "🔌 AVAILABLE COIL TYPES"
puts "-" * 40
Zeropoint::Coil.available_types.each do |type|
  info = Zeropoint::Coil.type_info(type)
  puts "• #{type.to_s.upcase}: #{info[:description]}"
  puts "  Math Module: #{info[:math_module]}"
  puts "  Metaphysical: #{info[:metaphysical]}"
  puts
end

puts "🧠 PHILOSOPHICAL INSIGHTS"
puts "-" * 40
insights = Zeropoint::Coil.insights
insights.each do |key, value|
  puts "• #{key.to_s.upcase}: #{value}"
end
puts

puts "🔬 COIL COMPARISON"
puts "-" * 40
comparison = Zeropoint::Coil.compare_types(:rodin, :toroidal, :regular)
comparison.each do |type, info|
  puts "• #{type.to_s.upcase}:"
  puts "  Description: #{info[:description]}"
  puts "  Math Module: #{info[:math_module]}"
  puts "  Metaphysical: #{info[:metaphysical]}"
  puts
end

puts "=" * 80
puts "RODIN COIL DEMONSTRATION"
puts "=" * 80
puts

# Create Rodin coil
rodin_coil = Zeropoint::Coil.create(:rodin, diameter: 5.0, turns: 30, gauge: 24)
puts "Created: #{rodin_coil}"
puts

puts "📋 SPECIFICATIONS"
specs = rodin_coil.specifications
puts "• Type: #{specs[:type]}"
puts "• Diameter: #{specs[:diameter]}\""
puts "• Turns: #{specs[:turns]}"
puts "• Gauge: #{specs[:gauge]}"
puts "• Magnetic Efficiency Gain: #{specs[:magnetic_efficiency_gain] * 100}%"
puts "• Copper Reduction: #{specs[:copper_reduction_min] * 100}%"
puts "• Position 1 Circuit: #{specs[:position_1_circuit].join(' → ')}"
puts "• Position 2 Circuit: #{specs[:position_2_circuit].join(' → ')}"
puts "• Gap Positions: #{specs[:gap_positions].join(', ')}"
puts

puts "⚡ ELECTRICITY PATTERN"
pattern = rodin_coil.electricity_pattern
puts "• Right Circuit: #{pattern[:right_circuit].join(' → ')}"
puts "• Left Circuit: #{pattern[:left_circuit].join(' → ')}"
puts "• Gap Spaces: #{pattern[:gap_spaces].join(', ')}"
puts

puts "🧲 FIELD MAPPING"
mapping = rodin_coil.field_mapping
puts "• Poloidal Flow: #{mapping[:poloidal_flow].join(' → ')}"
puts "• Toroidal Flow: #{mapping[:toroidal_flow].join(' → ')}"
puts "• Aperture Points: #{mapping[:aperture_points].join(', ')}"
puts "• Radius: #{mapping[:radius]}\""
puts "• Turns: #{mapping[:turns]}"
puts

puts "📐 GEOMETRY"
geometry = rodin_coil.geometry
puts "• Diameter: #{geometry[:diameter]}\""
puts "• Turns: #{geometry[:turns]}"
puts "• Gauge: #{geometry[:gauge]}"
puts "• Poloidal Circuit: #{geometry[:poloidal_circuit].join(' → ')}"
puts "• Toroidal Circuit: #{geometry[:toroidal_circuit].join(' → ')}"
puts

puts "🔍 VALIDATION & PATTERNS"
puts "• Valid Patterns: #{rodin_coil.valid?}"
puts "• Pattern Numbers: #{rodin_coil.pattern_numbers.join(', ')}"
puts "• Sequence Digital Root: #{rodin_coil.sequence_digital_root}"
puts

puts "📈 PERFORMANCE METRICS"
standard_output = 100.0
efficiency_gain = rodin_coil.efficiency_gain(standard_output)
copper_savings = rodin_coil.copper_savings(100.0)
puts "• Standard Output: #{standard_output} units"
puts "• Efficiency Gain: #{efficiency_gain} units (#{efficiency_gain/standard_output * 100}%)"
puts "• Copper Savings: #{copper_savings}%"
puts

puts "🧠 METAPHYSICAL INSIGHTS"
insights = rodin_coil.insights
insights.each do |key, value|
  puts "• #{key.to_s.upcase}: #{value}"
end
puts

puts "=" * 80
puts "TOROIDAL COIL DEMONSTRATION"
puts "=" * 80
puts

# Create Toroidal coil
toroidal_coil = Zeropoint::Coil.create(:toroidal, pegs: 16, step: 7, radius: 2.0)
puts "Created: #{toroidal_coil}"
puts

puts "📋 SPECIFICATIONS"
specs = toroidal_coil.specifications
puts "• Type: #{specs[:type]}"
puts "• Pegs: #{specs[:pegs]}"
puts "• Step: #{specs[:step]}"
puts "• Radius: #{specs[:radius]}"
puts "• Center: (#{specs[:center].join(', ')})"
puts "• Winding Sequence: #{specs[:winding_sequence].join(' → ')}"
puts

puts "🔄 WINDING SEQUENCES"
puts "• Current Sequence: #{toroidal_coil.sequence.join(' → ')}"
puts "• Available Steps: #{toroidal_coil.alternative_steps.join(', ')}"
puts

puts "📍 COORDINATES"
coords = toroidal_coil.coordinates
puts "• Number of Coordinates: #{coords.length}"
puts "• First Coordinate: (#{coords.first.join(', ')})"
puts "• Last Coordinate: (#{coords.last.join(', ')})"
puts

puts "📐 GEOMETRY"
geometry = toroidal_coil.geometry
puts "• Type: #{geometry[:type]}"
puts "• Pegs: #{geometry[:pegs]}"
puts "• Step: #{geometry[:step]}"
puts "• Radius: #{geometry[:radius]}"
puts "• Center: (#{geometry[:center].join(', ')})"
puts "• Segments: #{geometry[:segments].length} segments"
puts

puts "✅ VALIDATION"
puts "• Valid Configuration: #{toroidal_coil.valid?}"
puts

puts "🔄 ALTERNATIVE CONFIGURATIONS"
puts "• With Step 3: #{toroidal_coil.with_step(3)}"
puts "• With Radius 3.0: #{toroidal_coil.with_radius(3.0)}"
puts "• With Center [2, 2]: #{toroidal_coil.with_center([2.0, 2.0])}"
puts

puts "🧠 METAPHYSICAL INSIGHTS"
insights = toroidal_coil.insights
insights.each do |key, value|
  puts "• #{key.to_s.upcase}: #{value}"
end
puts

puts "🔧 APPLICATIONS"
apps = toroidal_coil.applications
apps.each do |app, description|
  puts "• #{app.to_s.upcase}: #{description}"
end
puts

puts "=" * 80
puts "REGULAR COIL DEMONSTRATION"
puts "=" * 80
puts

# Create Regular coil
regular_coil = Zeropoint::Coil.create(:regular, pegs: 8, radius: 1.5)
puts "Created: #{regular_coil}"
puts

puts "📋 SPECIFICATIONS"
specs = regular_coil.specifications
puts "• Type: #{specs[:type]}"
puts "• Pegs: #{specs[:pegs]}"
puts "• Step: #{specs[:step]} (fixed for unity)"
puts "• Radius: #{specs[:radius]}"
puts "• Center: (#{specs[:center].join(', ')})"
puts "• Winding Sequence: #{specs[:winding_sequence].join(' → ')}"
puts

puts "🔄 WINDING SEQUENCES"
puts "• Current Sequence: #{regular_coil.sequence.join(' → ')}"
puts "• Available Steps: #{regular_coil.alternative_steps.join(', ')}"
puts

puts "📍 COORDINATES"
coords = regular_coil.coordinates
puts "• Number of Coordinates: #{coords.length}"
puts "• First Coordinate: (#{coords.first.join(', ')})"
puts "• Last Coordinate: (#{coords.last.join(', ')})"
puts

puts "📐 GEOMETRY"
geometry = regular_coil.geometry
puts "• Type: #{geometry[:type]}"
puts "• Pegs: #{geometry[:pegs]}"
puts "• Step: #{geometry[:step]}"
puts "• Radius: #{geometry[:radius]}"
puts "• Center: (#{geometry[:center].join(', ')})"
puts "• Segments: #{geometry[:segments].length} segments"
puts

puts "✅ VALIDATION"
puts "• Valid Configuration: #{regular_coil.valid?}"
puts

puts "🔄 ALTERNATIVE CONFIGURATIONS"
puts "• With 12 Pegs: #{regular_coil.with_pegs(12)}"
puts "• With Radius 2.5: #{regular_coil.with_radius(2.5)}"
puts "• With Center [0.5, 0.5]: #{regular_coil.with_center([0.5, 0.5])}"
puts

puts "🧠 METAPHYSICAL INSIGHTS"
insights = regular_coil.insights
insights.each do |key, value|
  puts "• #{key.to_s.upcase}: #{value}"
end
puts

puts "🔧 APPLICATIONS"
apps = regular_coil.applications
apps.each do |app, description|
  puts "• #{app.to_s.upcase}: #{description}"
end
puts

puts "📊 COMPARISON WITH OTHER COILS"
comparison = regular_coil.comparison
comparison.each do |key, value|
  puts "• #{key.to_s.upcase}: #{value}"
end
puts

puts "=" * 80
puts "UNIFIED COIL SUMMARY"
puts "=" * 80
puts

puts "🎯 COIL TYPE DESCRIPTIONS"
descriptions = Zeropoint::Coil.type_descriptions
descriptions.each do |type, description|
  puts "• #{type.to_s.upcase}: #{description}"
end
puts

puts "🌌 METAPHYSICAL CONTEXTS"
contexts = Zeropoint::Coil.metaphysical_contexts
contexts.each do |type, context|
  puts "• #{type.to_s.upcase}: #{context}"
end
puts

puts "🔗 INTEGRATION POINTS"
puts "• All coils follow DRY principles and delegate to appropriate math modules"
puts "• Rodin coils integrate with Zeropoint::Math::RodinCoil"
puts "• Toroidal and Regular coils integrate with Zeropoint::Math::Coil"
puts "• Each coil type maintains its unique metaphysical context"
puts "• Unified API provides consistent interface across all coil types"
puts

puts "🎉 DEMONSTRATION COMPLETE!"
puts "The unified Zeropoint::Coil namespace successfully demonstrates:"
puts "• DRY architecture with modular design"
puts "• Toroidal geometry integration"
puts "• Metaphysical context preservation"
puts "• Object-oriented interfaces"
puts "• Comprehensive validation and testing"
puts "• Performance metrics and insights"
puts

puts "=" * 80 