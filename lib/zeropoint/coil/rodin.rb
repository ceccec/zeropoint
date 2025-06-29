# frozen_string_literal: true

require_relative '../math/rodin_coil'

module Zeropoint
  module Coil
    # Rodin: Advanced vortex-based mathematical torus coil
    # Delegates to Zeropoint::Math::RodinCoil for mathematical operations
    # Provides object-oriented interface with metaphysical context
    #
    # @see Zeropoint::Math::RodinCoil
    # @see docs/MARCO_RODIN_COILS_ANALYSIS.md
    class Rodin
      include Zeropoint::Math::RodinCoil

      attr_reader :diameter, :turns, :gauge, :options

      MAGNETIC_EFFICIENCY_GAIN = 0.625

      # Initialize a Rodin coil
      # @param diameter [Float] Coil diameter in inches (default: 4.0)
      # @param turns [Integer] Number of turns (default: 24)
      # @param gauge [Integer] Wire gauge (default: 26)
      # @param options [Hash] Additional configuration options
      def initialize(diameter: 4.0, turns: 24, gauge: 26, **options)
        @diameter = diameter
        @turns = turns
        @gauge = gauge
        @options = options
      end

      # Get coil specifications
      def specifications
        {
          type: :rodin,
          diameter: @diameter,
          turns: @turns,
          gauge: @gauge,
          magnetic_efficiency_gain: MAGNETIC_EFFICIENCY_GAIN,
          copper_reduction_min: COPPER_REDUCTION_MIN,
          position_1_circuit: POSITION_1_CIRCUIT,
          position_2_circuit: POSITION_2_CIRCUIT,
          gap_positions: GAP_POSITIONS,
        }
      end

      # Calculate field strength for this coil
      # @param base_strength [Float] Base magnetic field strength
      # @return [Float] Enhanced field strength
      def field_strength(base_strength)
        base_strength * (1 + MAGNETIC_EFFICIENCY_GAIN)
      end

      # Get synchronized electricity pattern for this coil
      # @return [Hash] Complete synchronized electricity configuration
      def electricity_pattern
        synchronized_electricity_pattern
      end

      # Get toroidal field mapping for this coil
      # @return [Hash] Complete toroidal field configuration
      def field_mapping
        toroidal_field_map(@diameter / 2.0, @turns)
      end

      # Get coil geometry for this instance
      # @return [Hash] Complete coil geometry
      def geometry
        coil_geometry(@diameter, @turns, @gauge)
      end

      # Calculate performance metrics for this coil
      # @param standard_coil_output [Float] Standard coil performance
      # @return [Hash] Performance comparison metrics
      def performance_metrics(standard_coil_output)
        super(standard_coil_output)
      end

      # Validate this coil's patterns
      # @return [Boolean] True if patterns are valid
      def valid?
        validate_patterns
      end

      # Get all pattern numbers for this coil
      # @return [Array<Integer>] All unique numbers in patterns
      def pattern_numbers
        all_pattern_numbers
      end

      # Get digital root of vortex sequence
      # @return [Integer] Digital root
      def sequence_digital_root
        vortex_sequence_digital_root
      end

      # Get advanced coil designs
      # @return [Hash] Advanced coil design specifications
      def advanced_designs
        advanced_coil_designs
      end

      # Get toroidal number mapping
      # @return [Hash] Complete toroidal number map
      def number_mapping
        toroidal_number_map
      end

      # Get applications for this coil
      # @return [Hash] Application use cases and specifications
      def applications
        super
      end

      # Get VBM integration points
      # @return [Hash] Integration points with other VBM modules
      def vbm_integration
        super
      end

      # Get metaphysical insights
      # @return [Hash] Metaphysical and philosophical insights
      def insights
        {
          metaphysical_meaning: 'Rodin coil embodies the vortex mathematics of consciousness',
          toroidal_flow: true,
          void_aligned: true,
        }
      end

      # Get electron flow optimization
      # @return [Hash] Electron flow optimization characteristics
      def flow_optimization
        electron_flow_optimization
      end

      # Get configuration parameters
      # @return [Hash] Configuration parameters for integration
      def configuration
        configuration_parameters
      end

      # Calculate efficiency gain for this coil
      # @param standard_output [Float] Standard coil magnetic output
      # @return [Float] Efficiency gain amount
      def efficiency_gain(standard_output)
        calculate_efficiency_gain(standard_output)
      end

      # Calculate copper savings for this coil
      # @param standard_copper [Float] Standard copper usage
      # @return [Float] Copper savings amount
      def copper_savings(standard_copper)
        calculate_copper_savings(standard_copper)
      end

      # Get coil summary
      # @return [Hash] Summary of coil properties
      def summary
        {
          type: :rodin,
          specifications: specifications,
          field_mapping: field_mapping,
          geometry: geometry,
          valid: valid?,
          pattern_numbers: pattern_numbers,
          sequence_digital_root: sequence_digital_root,
          insights: insights,
        }
      end

      # String representation
      def to_s
        "Rodin Coil (#{@diameter}\" diameter, #{@turns} turns, #{@gauge} gauge)"
      end

      # Inspect representation
      def inspect
        "#<#{self.class}: #{self}>"
      end
    end
  end
end
