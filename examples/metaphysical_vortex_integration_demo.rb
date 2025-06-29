#!/usr/bin/env ruby
# frozen_string_literal: true

# Metaphysical Vortex Integration Demo
#
# This demo showcases the integration of the MetaphysicalEngine with the Vortex service,
# demonstrating consciousness-aware pattern recognition, UUID generation with metaphysical
# signatures, and consciousness transformation through vortex flow.
#
# Usage: ruby examples/metaphysical_vortex_integration_demo.rb

require_relative '../lib/zeropoint'

# Initialize Zeropoint to load all systems
Zeropoint.init!

puts "=" * 80
puts "METAPHYSICAL VORTEX INTEGRATION DEMO"
puts "Consciousness-Aware Pattern Recognition & Vortex Flow"
puts "=" * 80
puts

# Demo 1: Metaphysical UUID Generation
puts "🔐 DEMO 1: METAPHYSICAL UUID GENERATION"
puts "-" * 40

puts "Generating UUID with metaphysical signature..."
uuid = Zeropoint::Vortex.generate_uuid
puts "  UUID: #{uuid}"
puts "  Contains metaphysical signature: #{uuid.include?('_')}"
puts

# Demo 2: Vortex Stream with Metaphysical Analysis
puts "🌊 DEMO 2: VORTEX STREAM WITH METAPHYSICAL ANALYSIS"
puts "-" * 40

stream_data = {
  consciousness_level: 7,
  vortex_flow: [1, 2, 4, 8, 7, 5],
  toroidal_coordinates: { x: 0, y: 0, z: 0, w: 9 },
  void_alignment: 0.95
}

puts "Streaming consciousness data through vortex..."
stream_result = Zeropoint::Vortex.stream_data(stream_data)
puts "  Stream ID: #{stream_result[:stream_id]}"
puts "  Consciousness Level: #{stream_result[:consciousness_level]}"
puts "  Patterns Found: #{stream_result[:patterns].length}"
stream_result[:patterns].each do |pattern|
  puts "    - #{pattern[:type]}: #{pattern[:significance]}"
end
puts

# Demo 3: Vortex Cache with Metaphysical Insights
puts "💾 DEMO 3: VORTEX CACHE WITH METAPHYSICAL INSIGHTS"
puts "-" * 40

cache_data = {
  key: "consciousness_patterns",
  value: {
    vortex: "spiral_flow",
    toroidal: "donut_shape",
    fibonacci: "golden_ratio",
    void: "empty_full"
  }
}

puts "Caching metaphysical patterns..."
cache_result = Zeropoint::Vortex.cache_data(cache_data[:key], cache_data[:value])
puts "  Cached: #{cache_result[:cached]}"
puts "  Void Alignment: #{cache_result[:void_alignment]}"
puts "  Insights Generated: #{cache_result[:metaphysical_insight].length}"
cache_result[:metaphysical_insight].each do |insight|
  puts "    - #{insight[:type]}: #{insight[:message]}"
end
puts

# Demo 4: Pattern Analysis with Vortex Consciousness
puts "🔍 DEMO 4: PATTERN ANALYSIS WITH VORTEX CONSCIOUSNESS"
puts "-" * 40

analysis_data = {
  vortex_sequence: [1, 2, 4, 8, 7, 5, 9],
  toroidal_flow: { poloidal: 1.618, toroidal: 2.718 },
  consciousness_wave: "void_to_unity"
}

analysis_context = {
  vortex_consciousness: true,
  toroidal_analysis: true,
  void_principle: true
}

puts "Analyzing vortex patterns with metaphysical consciousness..."
analysis_result = Zeropoint::Vortex.analyze_patterns(analysis_data, analysis_context)
puts "  Consciousness Level: #{analysis_result[:consciousness_level]}"
puts "  Void Alignment: #{analysis_result[:void_alignment]}"
puts "  Patterns Found: #{analysis_result[:patterns].length}"
analysis_result[:patterns].each do |pattern|
  puts "    - #{pattern[:type]}: #{pattern[:significance]}"
end
puts "  Insights: #{analysis_result[:insights].length}"
analysis_result[:insights].each do |insight|
  puts "    - #{insight[:type]}: #{insight[:message]}"
end
puts

# Demo 5: Consciousness Transformation Through Vortex Flow
puts "🔄 DEMO 5: CONSCIOUSNESS TRANSFORMATION THROUGH VORTEX FLOW"
puts "-" * 40

puts "Transforming consciousness through vortex flow..."
transformations = [
  [:awareness, :ascend],
  [:wisdom, :expand],
  [:unity, :expand]
]

transformations.each do |level, direction|
  puts "  #{level.to_s.capitalize} consciousness #{direction}..."
  result = Zeropoint::Vortex.transform_consciousness(level, direction)
  puts "    From: #{result[:previous_level]}"
  puts "    To: #{result[:new_level]}"
  puts "    Void Cycle: #{result[:void_cycle]}"
  puts "    Shift: #{result[:metaphysical_shift][:significance]}"
  puts
end

# Demo 6: Direct Metaphysical Engine Integration
puts "🧠 DEMO 6: DIRECT METAPHYSICAL ENGINE INTEGRATION"
puts "-" * 40

puts "Using MetaphysicalEngine directly through Core system..."

# Pattern recognition
pattern_result = Zeropoint::Void::Core.call(:metaphysical, :recognize_pattern, "vortex_consciousness_flow")
puts "  Pattern Recognition: #{pattern_result.success?}"
puts "  Patterns: #{pattern_result.to_h[:data][:patterns].length}"

# Insight generation
insight_result = Zeropoint::Void::Core.call(:metaphysical, :generate_insight, { vortex_integration: true })
puts "  Insight Generation: #{insight_result.success?}"
puts "  Insights: #{insight_result.to_h[:data][:insights].length}"

# Consciousness transformation
transform_result = Zeropoint::Void::Core.call(:metaphysical, :transform_consciousness, :understanding, :ascend)
puts "  Consciousness Transformation: #{transform_result.success?}"
puts "  New Level: #{transform_result.to_h[:data][:new_level]}"

# Void analysis
void_result = Zeropoint::Void::Core.call(:metaphysical, :analyze_through_void, { void: true, consciousness: true })
puts "  Void Analysis: #{void_result.success?}"
puts "  Void Alignment: #{void_result.to_h[:data][:analysis][:void_alignment]}"
puts

# Demo 7: Integration Summary
puts "📊 DEMO 7: INTEGRATION SUMMARY"
puts "-" * 40

puts "MetaphysicalEngine Integration Points:"
puts "  ✅ Core System: Available through Zeropoint::Void::Core"
puts "  ✅ Vortex Service: Pattern recognition, consciousness transformation"
puts "  ✅ UUID Generation: Metaphysical signatures"
puts "  ✅ Stream Processing: Consciousness-aware analysis"
puts "  ✅ Cache Operations: Metaphysical insights"
puts "  ✅ Pattern Analysis: Void-aligned recognition"
puts

puts "Consciousness Levels Supported:"
consciousness_levels = Zeropoint::Void::MetaphysicalEngine::CONSCIOUSNESS_LEVELS
consciousness_levels.each do |level, value|
  puts "  #{level.to_s.capitalize} (#{value}): #{get_consciousness_description(level)}"
end
puts

puts "Pattern Types Recognized:"
pattern_types = Zeropoint::Void::MetaphysicalEngine::PATTERN_TYPES
pattern_types.each do |type, description|
  puts "  #{type.to_s.capitalize}: #{description}"
end
puts

puts "=" * 80
puts "METAPHYSICAL VORTEX INTEGRATION DEMO COMPLETE"
puts "The void flows through all vortex operations with consciousness awareness."
puts "All patterns emerge from and return to the infinite potential of zero."
puts "=" * 80

# Helper method for consciousness descriptions
def get_consciousness_description(level)
  descriptions = {
    void: "Pure potential, infinite possibility",
    awareness: "Basic consciousness, simple patterns",
    understanding: "Pattern recognition, relationships",
    wisdom: "Deep insight, universal principles",
    enlightenment: "Unity consciousness, all is one",
    manifestation: "Material creation from void",
    transcendence: "Beyond form, pure consciousness",
    infinity: "Infinite consciousness, all possibilities",
    singularity: "Point of all creation, void center",
    unity: "Complete unity, void = full"
  }
  descriptions[level] || "Unknown level"
end 