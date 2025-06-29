# frozen_string_literal: true

require_relative '../math/coil'

module Zeropoint
  module Coil
    # Regular: Standard coil with basic winding patterns (step=1)
    # Represents the foundation pattern from which all other coils emerge
    # Delegates to Zeropoint::Math::Coil with step=1 for unity and simplicity
    #
    # @see Zeropoint::Math::Coil
    class Regular
      include Zeropoint::Math::Coil

      attr_reader :pegs, :radius, :center, :options

      # Initialize a Regular coil (step=1 for unity)
      # @param pegs [Integer] Number of pegs/points (default: 12)
      # @param radius [Float] Circle radius (default: 1.0)
      # @param center [Array<Float>] Center coordinates [x, y] (default: [0.0, 0.0])
      # @param options [Hash] Additional configuration options
      def initialize(pegs: 12, radius: 1.0, center: [ 0.0, 0.0 ], **options)
        @pegs = pegs
        @radius = radius
        @center = center
        @options = options
        @step = 1  # Fixed step=1 for regular coil
      end

      # Get coil specifications
      def specifications
        {
          type: :regular,
          pegs: @pegs,
          step: @step,
          radius: @radius,
          center: @center,
          winding_sequence: winding_sequence(@pegs, @step),
        }
      end

      # Get winding sequence for this coil (step=1)
      # @return [Array<Integer>] Winding sequence (1-based indices)
      def sequence
        winding_sequence(@pegs, @step)
      end

      # Get all possible winding sequences for this number of pegs
      # @return [Hash] All step sizes mapped to their sequences
      def all_sequences
        all_sequences(@pegs)
      end

      # Get peg coordinates for this coil
      # @return [Array<Array<Float>>] Array of [x, y] coordinates for each peg
      def coordinates
        peg_coordinates(@pegs, radius: @radius, center: @center)
      end

      # Get winding segments for this coil
      # @return [Array<Array<Integer>>] Array of [from_index, to_index] pairs
      def segments
        winding_segments(sequence)
      end

      # Get coil geometry summary
      # @return [Hash] Geometry information
      def geometry
        {
          type: :regular,
          pegs: @pegs,
          step: @step,
          radius: @radius,
          center: @center,
          coordinates: coordinates,
          segments: segments,
        }
      end

      # Check if this is a valid regular configuration
      # @return [Boolean] True if configuration is valid
      def valid?
        @pegs > 0 && @radius > 0
      end

      # Get alternative step sizes for this coil
      # @return [Array<Integer>] Available step sizes
      def alternative_steps
        (1...@pegs).to_a
      end

      # Get coil with different number of pegs
      # @param new_pegs [Integer] New number of pegs
      # @return [Regular] New coil instance
      def with_pegs(new_pegs)
        self.class.new(pegs: new_pegs, radius: @radius, center: @center, **@options)
      end

      # Get coil with different radius
      # @param new_radius [Float] New radius
      # @return [Regular] New coil instance
      def with_radius(new_radius)
        self.class.new(pegs: @pegs, radius: new_radius, center: @center, **@options)
      end

      # Get coil with different center
      # @param new_center [Array<Float>] New center coordinates [x, y]
      # @return [Regular] New coil instance
      def with_center(new_center)
        self.class.new(pegs: @pegs, radius: @radius, center: new_center, **@options)
      end

      # Get coil summary
      # @return [Hash] Summary of coil properties
      def summary
        {
          type: :regular,
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
          philosophy: 'The foundation pattern from which all other coils emerge',
          unity: 'Step=1 represents unity and the simplest possible pattern',
          foundation: 'Every complex pattern is built upon this basic foundation',
          simplicity: 'The most fundamental expression of toroidal geometry',
        }
      end

      # Get applications
      # @return [Hash] Application use cases
      def applications
        {
          education: 'Teaching basic toroidal mathematics principles',
          foundation: 'Base pattern for understanding more complex coils',
          reference: 'Standard reference for coil comparisons',
          simplicity: 'Applications requiring the simplest possible winding',
        }
      end

      # Get comparison with other coil types
      # @return [Hash] Comparison with Rodin and Toroidal coils
      def comparison
        {
          vs_rodin: 'Regular is foundation, Rodin is advanced vortex mathematics',
          vs_toroidal: 'Regular is step=1, Toroidal allows variable steps',
          complexity: 'Regular is simplest, others build upon this foundation',
          purpose: 'Regular is educational, others are specialized applications',
        }
      end

      # String representation
      def to_s
        "Regular Coil (#{@pegs} pegs, step #{@step}, radius #{@radius})"
      end

      # Inspect representation
      def inspect
        "#<#{self.class}: #{self}>"
      end
    end
  end
end
