# frozen_string_literal: true

module Zeropoint
  # Coil: Unified namespace for all coil types and implementations
  # Provides a clean, DRY API for Rodin, Toroidal, and Regular coils
  # Delegates to appropriate math modules while maintaining metaphysical context
  #
  # @see Zeropoint::Coil::Rodin
  # @see Zeropoint::Coil::Toroidal
  # @see Zeropoint::Coil::Regular
  # @see Zeropoint::Math::RodinCoil
  # @see Zeropoint::Math::Coil
  module Coil
    extend self

    # Configuration for coil types
    COIL_TYPES = {
      rodin: {
        description: 'Vortex-based mathematical torus coil with 62.5% efficiency gain',
        math_module: 'Zeropoint::Math::RodinCoil',
        metaphysical: 'Links science to metaphysics, religion, and Hopi culture',
      },
      toroidal: {
        description: 'Generic toroidal coil with modular/star/vortex winding patterns',
        math_module: 'Zeropoint::Math::Coil',
        metaphysical: 'Encodes the Mobius circuit and toroidal geometry',
      },
      regular: {
        description: 'Standard coil with basic winding patterns (step=1)',
        math_module: 'Zeropoint::Math::Coil',
        metaphysical: 'The foundation pattern from which all other coils emerge',
      },
    }.freeze

    # Get available coil types
    def available_types
      COIL_TYPES.keys
    end

    # Get coil type information
    def type_info(type)
      COIL_TYPES[type.to_sym]
    end

    # Get all coil type descriptions
    def type_descriptions
      COIL_TYPES.transform_values { |info| info[:description] }
    end

    # Get all metaphysical contexts
    def metaphysical_contexts
      COIL_TYPES.transform_values { |info| info[:metaphysical] }
    end

    # Unified coil creation method
    def create(type, **options)
      case type.to_sym
      when :rodin
        Rodin.new(**options)
      when :toroidal
        Toroidal.new(**options)
      when :regular
        Regular.new(**options)
      else
        raise ArgumentError, "Unknown coil type: #{type}. Available types: #{available_types.join(', ')}"
      end
    end

    # Compare coil types
    def compare_types(*types)
      types.map(&:to_sym).map { |type| [ type, type_info(type) ] }.to_h
    end

    # Get coil insights
    def insights
      {
        philosophy: 'All coils are manifestations of the toroidal universe pattern',
        rodin: 'Advanced vortex mathematics with synchronized electricity',
        toroidal: 'Generic toroidal geometry with flexible winding patterns',
        regular: 'Foundation pattern representing unity and simplicity',
        integration: 'Each coil type serves a specific purpose in the cosmic flow',
      }
    end
  end
end

# Load coil submodules
require_relative 'coil/rodin'
require_relative 'coil/toroidal'
require_relative 'coil/regular'
