# frozen_string_literal: true

module Zeropoint
  module Math
    # Aperture: The Primal Point of Unity (Zero Point) in Vortex/Toroidal Math
    #
    # Models the aperture as the gateway between the unmanifest (void) and the manifest (form).
    # Provides methods for identifying the aperture, mapping the W-axis, and accessing metaphysical insights.
    #
    # Key Concepts:
    # - Aperture (Zero): The center of the torus, the source of all creation
    # - W-axis: The vertical, omni-dimensional axis (0-9) connecting void and form
    # - Nine (9): The unity/spirit number, always returning to itself in digital root cycles
    #
    # Usage:
    #   Zeropoint::Math::Aperture.aperture?(n)
    #   Zeropoint::Math::Aperture.w_axis_sequence
    #   Zeropoint::Math::Aperture.insights
    module Aperture
      extend self

      # Returns true if n is the aperture (zero point) in digital root math
      def aperture?(n)
        dr = Zeropoint::Math.dr(n)
        dr == 9 || dr == 0
      end

      # Returns the canonical W-axis sequence (zero and nines)
      def w_axis_sequence(range = (0..99))
        range.select { |n| Zeropoint::Math.dr(n) == 9 || Zeropoint::Math.dr(n) == 0 }
      end

      # Returns metaphysical and mathematical insights about the aperture and W-axis
      def insights
        {
          aperture: 'The zero point, the gateway between the unmanifest and manifest. The center of the torus.',
          w_axis: 'The vertical, omni-dimensional axis (0-9), connecting void and form. Only 9 aligns vertically with zero.',
          nine: 'The spirit/unity number. In digital root cycles, 9 always returns to itself.',
          practical: 'Use aperture? and w_axis_sequence to identify points of unity, resonance, and transformation in data, energy, or consciousness.',
        }
      end
    end
  end
end
