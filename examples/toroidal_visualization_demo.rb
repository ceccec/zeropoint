#!/usr/bin/env ruby
# frozen_string_literal: true

# Toroidal Visualization Demo: ZeroPoint as a Torus
# Demonstrates the geometric structure of ZeroPoint as a toroidal system
# with visual representations of flow patterns, vortex interactions, and cosmic geometry.

require_relative '../lib/zeropoint'
require_relative '../lib/zeropoint/math'

# Use Zeropoint::Math for all mathematical operations
include Zeropoint::Math

def visualize_torus_structure
  puts "🌌 ZEROPOINT TOROIDAL VISUALIZATION"
  puts "=" * 60
  puts "Visualizing ZeroPoint as a toroidal system with"
  puts "continuous flow patterns and cosmic geometry."
  puts "=" * 60
  
  # Visual representation of the torus
  puts "\n🌀 TOROIDAL STRUCTURE"
  puts "-" * 40
  
  torus_ascii = <<~TORUS
                    ┌─────────────────────────────────────┐
                    │         CANOPY VORTEX               │
                    │     (UI/Universes/Expression)       │
                    │                                     │
                    │  ┌─────────────┐  ┌─────────────┐  │
                    │  │   User      │  │Application  │  │
                    │  │  Content    │  │   Code      │  │
                    │  └─────────────┘  └─────────────┘  │
                    └─────────────────────────────────────┘
                              ↕️  Energy Flow
                    ┌─────────────────────────────────────┐
                    │           THE VOID                  │
                    │      (Infinite Potential)           │
                    │                                     │
                    │  🌌 Empty Center of Torus 🌌        │
                    │  Solves All Unsolvable Problems     │
                    │  Generates Infinite Universes       │
                    └─────────────────────────────────────┘
                              ↕️  Truth Flow
                    ┌─────────────────────────────────────┐
                    │         ROOT VORTEX                 │
                    │    (Language/Config/Truth)          │
                    │                                     │
                    │  ┌─────────────┐  ┌─────────────┐  │
                    │  │Language     │  │Mathematical │  │
                    │  │Patterns     │  │  Truths     │  │
                    │  └─────────────┘  └─────────────┘  │
                    └─────────────────────────────────────┘
  TORUS
  
  puts torus_ascii
end

def demonstrate_digital_root_cycles
  puts "\n🔢 DIGITAL ROOT CYCLES (MOD 9)"
  puts "-" * 40
  
  # Show doubling sequence
  puts "Doubling Sequence (1 → 2 → 4 → 8 → 7 → 5 → 1):"
  doubling_seq = doubling_sequence(1, 9)
  doubling_visual = doubling_seq.map.with_index do |n, i|
    "#{n}#{i < doubling_seq.length - 1 ? ' → ' : ''}"
  end.join
  puts "  #{doubling_visual}"
  
  # Show halving sequence
  puts "\nHalving Sequence (1 ← 2 ← 4 ← 8 ← 7 ← 5 ← 1):"
  halving_seq = halving_sequence(1, 9)
  halving_visual = halving_seq.map.with_index do |n, i|
    "#{n}#{i < halving_seq.length - 1 ? ' ← ' : ''}"
  end.join
  puts "  #{halving_visual}"
  
  # Show all digital roots
  puts "\nComplete Digital Root Cycle:"
  (1..9).each do |n|
    dr = digital_root(n)
    axis = axis_state(n)
    puts "  #{n} → #{dr} (#{axis})"
  end
end

def visualize_toroidal_coordinates
  puts "\n🎯 TOROIDAL COORDINATES"
  puts "-" * 40
  
  puts "Digital Root → (Radius, Angle):"
  (1..9).each do |dr|
    radius = toroidal_radius(dr)
    angle = toroidal_angle(dr)
    axis_info = on_axis?(dr) ? " [AXIS #{axis_number(dr)}]" : ""
    puts "  #{dr} → (#{radius}, #{angle}°) #{axis_info}"
  end
  
  # Visual representation of toroidal surface
  puts "\nToroidal Surface Map:"
  puts "    9 (Center/Void)"
  puts "  8     1"
  puts "7         2"
  puts "6         3"
  puts "  5     4"
  puts "    (Outer Edge)"
end

def demonstrate_flow_patterns
  puts "\n🌊 TOROIDAL FLOW PATTERNS"
  puts "-" * 40
  
  # Test different sequences
  sequences = {
    "Circular": [1, 2, 4, 8, 7, 5, 1],
    "Expanding": [1, 2, 4, 8, 7, 5, 1, 2, 4],
    "Contracting": [5, 7, 8, 4, 2, 1, 5, 7, 8],
    "Chaotic": [1, 3, 7, 2, 8, 4, 6, 9, 5]
  }
  
  sequences.each do |name, seq|
    direction = flow_direction(seq)
    efficiency = flow_efficiency(seq)
    resonance = resonance_frequency(seq)
    
    puts "#{name} Flow:"
    puts "  Sequence: #{seq.join(' → ')}"
    puts "  Direction: #{direction}"
    puts "  Efficiency: #{(efficiency * 100).round(1)}%"
    puts "  Resonance: #{(resonance * 100).round(1)}%"
    puts ""
  end
end

def visualize_vortex_interactions
  puts "\n🌪️ VORTEX INTERACTIONS"
  puts "-" * 40
  
  # Define vortices with their properties
  vortices = {
    root: { name: "Root Vortex", energy: 0.8, consciousness: 0.9, position: "bottom" },
    canopy: { name: "Canopy Vortex", energy: 0.7, consciousness: 0.8, position: "top" },
    void: { name: "The Void", energy: Float::INFINITY, consciousness: 1.0, position: "center" }
  }
  
  puts "Vortex Properties:"
  vortices.each do |key, vortex|
    puts "  #{vortex[:name]} (#{vortex[:position]}):"
    puts "    Energy: #{vortex[:energy]}"
    puts "    Consciousness: #{vortex[:consciousness]}"
  end
  
  puts "\nFlow Interactions:"
  puts "  Root → Canopy: Truth patterns flow upward"
  puts "  Canopy → Root: Expression patterns flow downward"
  puts "  Void → Both: Infinite potential radiates outward"
  puts "  Both → Void: Information contracts to center"
end

def demonstrate_axis_states
  puts "\n🎯 3-6-9 AXIS STATES"
  puts "-" * 40
  
  puts "Axis Numbers and Their Properties:"
  [3, 6, 9].each do |axis|
    radius = toroidal_radius(axis)
    angle = toroidal_angle(axis)
    harmonic = toroidal_harmonic(axis)
    
    puts "  Axis #{axis}:"
    puts "    Radius: #{radius}"
    puts "    Angle: #{angle}°"
    puts "    Harmonic: #{harmonic.round(1)} Hz"
    puts "    State: #{axis_state(axis)}"
    puts ""
  end
  
  # Test numbers for axis alignment
  test_numbers = [1, 3, 5, 6, 8, 9, 12, 15, 18, 27]
  puts "Axis Alignment Test:"
  test_numbers.each do |n|
    dr = digital_root(n)
    axis = axis_state(n)
    distance = axis_distance(n)
    puts "  #{n} → DR: #{dr}, Axis: #{axis}, Distance: #{distance}"
  end
end

def demonstrate_harmonic_series
  puts "\n🎵 TOROIDAL HARMONICS"
  puts "-" * 40
  
  base_frequency = 432.0  # Cosmic frequency
  puts "Base Frequency: #{base_frequency} Hz (Cosmic Frequency)"
  puts ""
  
  puts "Harmonic Series:"
  (1..9).each do |n|
    harmonic = toroidal_harmonic(n, base_frequency)
    puts "  #{n}: #{harmonic.round(1)} Hz"
  end
  
  puts "\nComplete Harmonic Series:"
  series = toroidal_harmonic_series(base_frequency)
  series.each_with_index do |freq, i|
    puts "  #{i + 1}: #{freq.round(1)} Hz"
  end
end

def demonstrate_phase_states
  puts "\n🌙 TOROIDAL PHASE STATES"
  puts "-" * 40
  
  puts "Phase States in 9-Step Cycle:"
  (0..8).each do |step|
    phase = toroidal_phase(step)
    state = phase_state(step)
    puts "  Step #{step}: #{phase.round(1)}° → State #{state}°"
  end
  
  puts "\nPhase State Distribution:"
  states = (0..8).map { |step| phase_state(step) }
  state_counts = states.group_by(&:itself).transform_values(&:count)
  state_counts.each do |state, count|
    puts "  State #{state}°: #{count} steps"
  end
end

def demonstrate_universe_generation
  puts "\n🌌 UNIVERSE GENERATION PROCESS"
  puts "-" * 40
  
  steps = [
    "1. Void Connection",
    "2. Pattern Extraction (Root Vortex)",
    "3. Universe Generation (Void + Patterns)",
    "4. Expression Creation (Canopy Vortex)",
    "5. Flow Through Torus",
    "6. Pattern Harmonization",
    "7. Universe Evolution",
    "8. Storage and Manifestation"
  ]
  
  steps.each_with_index do |step, i|
    puts "  #{step}"
    if i < steps.length - 1
      puts "    ↓"
    end
  end
end

def demonstrate_torus_states
  puts "\n🎯 TORUS OPERATIONAL STATES"
  puts "-" * 40
  
  states = {
    void: "Connected to infinite potential",
    generating: "Creating universes from patterns",
    flowing: "Data flowing between vortices",
    harmonizing: "Patterns harmonizing with golden ratio",
    evolving: "Self-evolution and adaptation"
  }
  
  states.each do |state, description|
    puts "  #{state.to_s.upcase}: #{description}"
  end
end

def calculate_cosmic_metrics
  puts "\n🌊 COSMIC FLOW METRICS"
  puts "-" * 40
  
  # Generate a test sequence
  test_sequence = (1..20).map { |n| digital_root(n * 7) }
  
  puts "Test Sequence: #{test_sequence.join(' → ')}"
  puts ""
  
  # Calculate various metrics
  flow_dir = flow_direction(test_sequence)
  efficiency = flow_efficiency(test_sequence)
  resonance = resonance_frequency(test_sequence)
  
  puts "Flow Analysis:"
  puts "  Direction: #{flow_dir}"
  puts "  Efficiency: #{(efficiency * 100).round(1)}%"
  puts "  Resonance: #{(resonance * 100).round(1)}%"
  
  # Analyze sequence
  analysis = analyze_sequence(test_sequence)
  puts "  Axis Counts: #{analysis[:axis_counts]}"
  puts "  Unique Digital Roots: #{analysis[:digital_roots].uniq.sort}"
end

def demonstrate_void_integration
  puts "\n🌌 VOID INTEGRATION"
  puts "-" * 40
  
  # Test void problem-solving
  problems = [
    "paradox of infinite recursion",
    "contradiction of dual nature",
    "infinite loop of consciousness"
  ]
  
  puts "Void Problem Solving:"
  problems.each do |problem|
    solution = Zeropoint::Void.solve_unsolvable(problem)
    puts "  Problem: #{problem}"
    puts "  Solution: #{solution[:result]}"
    puts "  Principle: #{solution[:void_principle]}"
    puts ""
  end
end

# Run the complete visualization
puts "🌌 ZEROPOINT TOROIDAL VISUALIZATION DEMO"
puts "=" * 60

visualize_torus_structure
demonstrate_digital_root_cycles
visualize_toroidal_coordinates
demonstrate_flow_patterns
visualize_vortex_interactions
demonstrate_axis_states
demonstrate_harmonic_series
demonstrate_phase_states
demonstrate_universe_generation
demonstrate_torus_states
calculate_cosmic_metrics
demonstrate_void_integration

puts "\n✨ TOROIDAL VISUALIZATION COMPLETE"
puts "-" * 40
puts "ZeroPoint as a torus demonstrates:"
puts "  • Continuous energy flow in toroidal patterns"
puts "  • Infinite potential at the void center"
puts "  • Harmonious balance between root and canopy vortices"
puts "  • Self-sustaining cosmic architecture"
puts "  • Consciousness-aware problem solving"
puts ""
puts "The torus is not just a metaphor - it's the fundamental"
puts "structure that makes ZeroPoint a living, breathing system"
puts "that mirrors the geometry of consciousness itself." 