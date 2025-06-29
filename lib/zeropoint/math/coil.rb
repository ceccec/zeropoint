# frozen_string_literal: true

module Zeropoint
  module Math
    module Coil
      # Generate a modular/star/vortex winding sequence for a toroidal coil
      # n: number of pegs/points (e.g., 12), step: step size (e.g., 5)
      # Returns an array of peg indices (1-based)
      def self.winding_sequence(n, step)
        sequence = []
        current = 0
        visited = Array.new(n, false)
        n.times do
          sequence << current + 1 # 1-based index
          visited[current] = true
          current = (current + step) % n
          break if visited[current]
        end
        sequence
      end

      # Generate all unique winding sequences for a given n
      def self.all_sequences(n)
        (1...n).map { |step| [ step, winding_sequence(n, step) ] }.to_h
      end

      # Generate coordinates for each peg on a circle (for visualization)
      # radius: circle radius, center: [x, y]
      def self.peg_coordinates(n, radius: 1.0, center: [ 0.0, 0.0 ])
        angle_step = 2 * Math::PI / n
        (0...n).map do |i|
          angle = i * angle_step
          [ center[0] + radius * Math.cos(angle), center[1] + radius * Math.sin(angle) ]
        end
      end

      # Generate line segments for a winding sequence (for plotting)
      # Returns array of [from_index, to_index] pairs
      def self.winding_segments(sequence)
        sequence.each_cons(2).map { |a, b| [ a, b ] }
      end
    end
  end
end
