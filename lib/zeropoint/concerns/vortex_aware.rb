# frozen_string_literal: true

module Zeropoint
  module Concerns
    module VortexAware
      # Use coil for all vortex field calculations
      def vortex_field_strength(base_strength)
        Zeropoint::Coil::Rodin.new.field_strength(base_strength)
      end

      def vortex_sequence(n, step = 5)
        Zeropoint::Coil::Toroidal.new(pegs: n, step: step).sequence
      end

      def toroidal_field_mapping(radius, turns = 24)
        Zeropoint::Coil::Rodin.new(diameter: radius * 2, turns: turns).field_mapping
      end

      def synchronized_electricity_pattern
        Zeropoint::Coil::Rodin.new.electricity_pattern
      end

      def vortex_insights
        Zeropoint::Coil::Rodin.new.insights
      end

      # Legacy method aliases for backward compatibility
      def vortex_aware?
        true
      end

      def vortex_optimization_enabled?
        Zeropoint.config.coil_enabled
      end

      # Class methods
      def self.vortex_sequence(n, step = 5)
        Zeropoint::Coil::Toroidal.new(pegs: n, step: step).sequence
      end

      def self.all_vortex_sequences(n)
        Zeropoint::Coil::Toroidal.new(pegs: n).all_sequences
      end
    end
  end
end
