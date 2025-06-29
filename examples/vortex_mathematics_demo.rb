#!/usr/bin/env ruby
# frozen_string_literal: true

# Vortex Mathematics Demo
# Demonstrates Marco Rodin's vortex math and its use in the Zero Point gem

require_relative '../lib/graphql_ui_layout/vortex/vortex_mathematics'

module Demo
  include GraphqlUiLayout::Vortex::VortexMathematics
end

puts "🌪️ VORTEX MATHEMATICS DEMO"
puts "==========================="

# Vortex reduction
puts "\nVortex reduction of 137:"
puts "  137 → #{Demo.vortex_reduce(137)}"

# Doubling sequence
puts "\nVortex doubling sequence (12 steps):"
seq = Demo.doubling_sequence(12)
puts "  #{seq.inspect}"

# Analyze a data flow (simulate error counts)
data_flow = [ 3, 6, 12, 24, 48, 96, 192, 384, 768, 1536 ]
analysis = Demo.analyze_sequence(data_flow)
puts "\nAnalyzing data flow: #{data_flow.inspect}"
puts "  Vortex digits: #{analysis[:vortex_digits].inspect}"
puts "  Axis hits (3,6,9): #{analysis[:axis_hits]} at positions #{analysis[:axis_positions].inspect}"
puts "  Cycle matches: #{analysis[:cycle_matches].inspect}"

# Visualize the cycle
puts "\nVortex cycle visualization (with axis):"
puts Demo.visualize_cycle([ 1, 2, 4, 8, 7, 5, 3, 6, 9 ])
