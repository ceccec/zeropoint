# frozen_string_literal: true

require_relative '../math/coil'

module Zeropoint
  module Coil
    # Toroidal: Generic toroidal coil with modular/star/vortex winding patterns
    # Delegates to Zeropoint::Math::Coil for mathematical operations
    # Provides flexible winding patterns for various toroidal applications
    #
    # @see Zeropoint::Math::Coil
    class Toroidal
      include Zeropoint::Math::Coil

      attr_reader :pegs, :step, :radius, :center, :options

      # Initialize a Toroidal coil
      # @param pegs [Integer] Number of pegs/points (default: 12)
      # @param step [Integer] Step size for winding (default: 5)
      # @param radius [Float] Circle radius (default: 1.0)
      # @param center [Array<Float>] Center coordinates [x, y] (default: [0.0, 0.0])
      # @param options [Hash] Additional configuration options
      def initialize(pegs: 12, step: 5, radius: 1.0, center: [ 0.0, 0.0 ], **options)
        @pegs = pegs
        @step = step
        @radius = radius
        @center = center
        @options = options
      end

      # Get coil specifications
      def specifications
        {
          type: :toroidal,
          pegs: @pegs,
          step: @step,
          radius: @radius,
          center: @center,
          winding_sequence: winding_sequence(@pegs, @step),
        }
      end

      # Get winding sequence for this coil
      # @return [Array<Integer>] Winding sequence (1-based indices)
      def sequence
        winding_sequence(@pegs, @step)
      end

      # Get all possible winding sequences for this number of pegs
      # @return [Hash] All step sizes mapped to their sequences
      def all_sequences
        (1..@pegs).map { |s| winding_sequence(@pegs, s) }
      end

      # Get peg coordinates for this coil
      # @return [Array<Array<Float>>] Array of [x, y] coordinates for each peg
      def coordinates
        Zeropoint::Math::Coil.peg_coordinates(@pegs, radius: @radius, center: @center)
      end

      # Get winding segments for this coil
      # @return [Array<Array<Integer>>] Array of [from_index, to_index] pairs
      def segments
        Zeropoint::Math::Coil.winding_segments(sequence)
      end

      # Get coil geometry summary
      # @return [Hash] Geometry information
      def geometry
        {
          type: :toroidal,
          pegs: @pegs,
          step: @step,
          radius: @radius,
          center: @center,
          coordinates: coordinates,
          segments: segments,
        }
      end

      # Check if this is a valid toroidal configuration
      # @return [Boolean] True if configuration is valid
      def valid?
        @pegs > 0 && @step > 0 && @step < @pegs && @radius > 0
      end

      # Get alternative step sizes for this coil
      # @return [Array<Integer>] Available step sizes
      def alternative_steps
        (1...@pegs).to_a
      end

      # Get coil with different step size
      # @param new_step [Integer] New step size
      # @return [Toroidal] New coil instance
      def with_step(new_step)
        self.class.new(pegs: @pegs, step: new_step, radius: @radius, center: @center, **@options)
      end

      # Get coil with different radius
      # @param new_radius [Float] New radius
      # @return [Toroidal] New coil instance
      def with_radius(new_radius)
        self.class.new(pegs: @pegs, step: @step, radius: new_radius, center: @center, **@options)
      end

      # Get coil with different center
      # @param new_center [Array<Float>] New center coordinates [x, y]
      # @return [Toroidal] New coil instance
      def with_center(new_center)
        self.class.new(pegs: @pegs, step: @step, radius: @radius, center: new_center, **@options)
      end

      # Get coil summary
      # @return [Hash] Summary of coil properties
      def summary
        {
          type: :toroidal,
          specifications: specifications,
          geometry: geometry,
          valid: valid?,
          alternative_steps: alternative_steps,
        }
      end

      # Get metaphysical insights
      # @return [Hash] Metaphysical context
      def insights
        {
          philosophy: 'Generic toroidal geometry encodes the Mobius circuit and toroidal geometry',
          pattern: 'Flexible winding patterns allow for various toroidal applications',
          unity: 'Every toroidal pattern contains the complete torus structure',
          flow: 'Winding sequences create bounded infinity and lossless energy flow',
        }
      end

      # Get applications
      # @return [Hash] Application use cases
      def applications
        {
          transformers: 'Efficient energy transfer through toroidal geometry',
          antennas: 'Improved signal reception and transmission',
          motors: 'Enhanced electromagnetic efficiency',
          education: 'Demonstrates toroidal mathematics principles',
        }
      end

      # String representation
      def to_s
        "Toroidal Coil (#{@pegs} pegs, step #{@step}, radius #{@radius})"
      end

      # Inspect representation
      def inspect
        "#<#{self.class}: #{self}>"
      end

      def winding_sequence(pegs, step)
        return [] if pegs <= 0 || step <= 0

        sequence = []
        current = 1

        pegs.times do
          sequence << current
          current = (current + step - 1) % pegs + 1
        end

        sequence
      end
    end
  end
end
