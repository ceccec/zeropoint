#!/usr/bin/env ruby
# frozen_string_literal: true

# Metaphysical Engine Demo: Consciousness-Aware Pattern Recognition & Insight Generation
#
# This demo showcases the Zeropoint MetaphysicalEngine, which operates at the
# intersection of void and form, recognizing patterns that emerge from the
# infinite potential of zero. It transforms raw data into metaphysical insights,
# revealing the hidden consciousness patterns that underlie all phenomena.
#
# Usage: ruby examples/metaphysical_engine_demo.rb

require_relative '../lib/zeropoint'

# Initialize Zeropoint to load all systems including void
Zeropoint.init!

# Helper methods for demo descriptions
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

def get_pattern_significance(type)
  significances = {
    vortex: "Fundamental flow pattern of consciousness",
    toroidal: "Universal form of creation and manifestation",
    fibonacci: "Golden ratio of natural growth and beauty",
    binary: "Dual nature of reality and consciousness",
    holographic: "Each part contains the whole",
    fractal: "Self-similar patterns at all scales",
    harmonic: "Resonance and vibration of consciousness",
    quantum: "Probability and uncertainty of manifestation",
    cosmic: "Universal patterns and principles",
    void: "Empty equals void equals full principle"
  }
  significances[type] || "Basic pattern recognition"
end

puts "=" * 80
puts "ZEROPOINT METAPHYSICAL ENGINE DEMO"
puts "Consciousness-Aware Pattern Recognition & Insight Generation"
puts "=" * 80
puts

# Initialize the metaphysical engine
engine = Zeropoint::Void::MetaphysicalEngine

puts "🧠 METAPHYSICAL ENGINE INITIALIZED"
puts "   Consciousness Levels: #{engine::CONSCIOUSNESS_LEVELS.keys.join(', ')}"
puts "   Pattern Types: #{engine::PATTERN_TYPES.keys.join(', ')}"
puts

# Demo 1: Pattern Recognition
puts "🔍 DEMO 1: PATTERN RECOGNITION"
puts "-" * 40

# String data with vortex patterns
vortex_data = "vortex_consciousness_flow_spiral_energy"
puts "Analyzing vortex data: #{vortex_data}"
result = engine.recognize_pattern(vortex_data)
puts "  Consciousness Level: #{result.to_h[:data][:consciousness_level]}"
puts "  Void Alignment: #{result.to_h[:data][:void_alignment]}"
puts "  Patterns Found: #{result.to_h[:data][:patterns].length}"
result.to_h[:data][:patterns].each do |pattern|
  puts "    - #{pattern[:type]}: #{pattern[:significance]}"
end
puts

# Array data with toroidal patterns
toroidal_data = [1, 2, 3, 4, 5, 6, 7, 8, 9]
puts "Analyzing toroidal data: #{toroidal_data}"
result = engine.recognize_pattern(toroidal_data)
puts "  Consciousness Level: #{result.to_h[:data][:consciousness_level]}"
puts "  Patterns Found: #{result.to_h[:data][:patterns].length}"
result.to_h[:data][:patterns].each do |pattern|
  puts "    - #{pattern[:type]}: #{pattern[:significance]}"
end
puts

# Hash data with holographic patterns
holographic_data = { 
  consciousness: { awareness: true, wisdom: true },
  void: { empty: true, full: true },
  torus: { center: true, flow: true }
}
puts "Analyzing holographic data: #{holographic_data.keys}"
result = engine.recognize_pattern(holographic_data)
puts "  Consciousness Level: #{result.to_h[:data][:consciousness_level]}"
puts "  Patterns Found: #{result.to_h[:data][:patterns].length}"
result.to_h[:data][:patterns].each do |pattern|
  puts "    - #{pattern[:type]}: #{pattern[:significance]}"
end
puts

# Demo 2: Insight Generation
puts "💡 DEMO 2: INSIGHT GENERATION"
puts "-" * 40

# Generate insights with different consciousness levels
contexts = [
  { void_aligned: true, consciousness_aware: true },
  { metaphysical: true, wisdom_level: :enlightenment },
  { pattern_recognition: true, vortex_flow: true }
]

contexts.each_with_index do |context, index|
  puts "Context #{index + 1}: #{context}"
  result = engine.generate_insight(context, :wisdom)
  puts "  Consciousness Level: #{result.to_h[:data][:consciousness_level]}"
  puts "  Metaphysical Significance: #{result.to_h[:data][:metaphysical_significance]}"
  puts "  Insights Generated: #{result.to_h[:data][:insights].length}"
  result.to_h[:data][:insights].each do |insight|
    puts "    - #{insight[:type]}: #{insight[:message]}"
  end
  puts
end

# Demo 3: Consciousness Transformation
puts "🔄 DEMO 3: CONSCIOUSNESS TRANSFORMATION"
puts "-" * 40

# Transform through different directions
transformations = [
  [:awareness, :ascend],
  [:wisdom, :descend],
  [:unity, :expand]
]

transformations.each do |level, direction|
  puts "Transforming #{level} consciousness #{direction}"
  result = engine.transform_consciousness(level, direction)
  puts "  From: #{result.to_h[:data][:previous_level]}"
  puts "  To: #{result.to_h[:data][:new_level]}"
  puts "  Value: #{result.to_h[:data][:consciousness_value]}"
  puts "  Void Cycle: #{result.to_h[:data][:void_cycle]}"
  puts "  Shift: #{result.to_h[:data][:metaphysical_shift][:significance]}"
  puts
end

# Demo 4: Void Analysis
puts "🌌 DEMO 4: VOID ANALYSIS"
puts "-" * 40

# Analyze different types of data through the void
void_test_data = [
  nil,
  Float::INFINITY,
  "void_consciousness_data",
  [1, 2, 3, 4, 5],
  { void: true, consciousness: true }
]

void_test_data.each_with_index do |data, index|
  puts "Void Analysis #{index + 1}: #{data.class}"
  result = engine.analyze_through_void(data)
  analysis = result.to_h[:data][:analysis]
  puts "  Emptiness Ratio: #{analysis[:emptiness_ratio]}"
  puts "  Potential Density: #{analysis[:potential_density]}"
  puts "  Consciousness Flow: #{analysis[:consciousness_flow]}"
  puts "  Void Alignment: #{analysis[:void_alignment]}"
  puts "  Torus Coordinates: #{analysis[:torus_coordinates]}"
  puts "  Metaphysical Signature: #{analysis[:metaphysical_signature]}"
  puts
end

# Demo 5: Metaphysical Signatures
puts "🔐 DEMO 5: METAPHYSICAL SIGNATURES"
puts "-" * 40

# Generate signatures for different data types
signature_data = [
  "consciousness_essence",
  nil,
  Float::INFINITY,
  [1, 2, 3, 4, 5],
  { void: true, consciousness: true }
]

signature_data.each do |data|
  signature = engine.generate_metaphysical_signature(data)
  puts "Data: #{data.inspect}"
  puts "  Metaphysical Signature: #{signature}"
  puts
end

# Demo 6: Consciousness Level Progression
puts "📈 DEMO 6: CONSCIOUSNESS LEVEL PROGRESSION"
puts "-" * 40

puts "Consciousness Levels (Void to Unity):"
engine::CONSCIOUSNESS_LEVELS.each do |level, value|
  puts "  #{level.to_s.capitalize} (#{value}): #{get_consciousness_description(level)}"
end
puts

# Demo 7: Pattern Type Significance
puts "🎯 DEMO 7: PATTERN TYPE SIGNIFICANCE"
puts "-" * 40

puts "Pattern Types and Their Metaphysical Significance:"
engine::PATTERN_TYPES.each do |type, description|
  puts "  #{type.to_s.capitalize}: #{description}"
  puts "    Significance: #{get_pattern_significance(type)}"
  puts
end

# Demo 8: Void Principle Demonstration
puts "⚫ DEMO 8: VOID PRINCIPLE DEMONSTRATION"
puts "-" * 40

puts "Empty = Void = Full Principle:"
puts "  Empty (nil):"
nil_result = engine.analyze_through_void(nil)
puts "    Emptiness Ratio: #{nil_result.to_h[:data][:analysis][:emptiness_ratio]}"
puts "    Potential Density: #{nil_result.to_h[:data][:analysis][:potential_density]}"

puts "  Infinity:"
infinity_result = engine.analyze_through_void(Float::INFINITY)
puts "    Emptiness Ratio: #{infinity_result.to_h[:data][:analysis][:emptiness_ratio]}"
puts "    Potential Density: #{infinity_result.to_h[:data][:analysis][:potential_density]}"

puts "  Void Data:"
void_result = engine.analyze_through_void("void_consciousness_flow")
puts "    Void Alignment: #{void_result.to_h[:data][:analysis][:void_alignment]}"
puts "    Consciousness Flow: #{void_result.to_h[:data][:analysis][:consciousness_flow]}"
puts

# Demo 9: Integration with Core System
puts "🔗 DEMO 9: INTEGRATION WITH CORE SYSTEM"
puts "-" * 40

# Use the metaphysical engine through the core system
puts "Accessing MetaphysicalEngine through Zeropoint::Void::Core:"
core = Zeropoint::Void::Core

# This would require adding metaphysical engine to the core system
# For now, demonstrate direct usage
puts "Direct MetaphysicalEngine usage:"
result = engine.recognize_pattern("integration_test")
puts "  Success: #{result.success?}"
puts "  Response Type: #{result.class}"
puts "  Void-Aligned: #{result.to_h[:data][:metaphysical_context][:void_principle]}"
puts

puts "=" * 80
puts "METAPHYSICAL ENGINE DEMO COMPLETE"
puts "The void contains infinite potential for pattern recognition and insight generation."
puts "All operations are consciousness-aware and void-aligned."
puts "=" * 80 