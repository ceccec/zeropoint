# frozen_string_literal: true

require_relative 'vortex/math'
# require_relative 'vortex/math/torus' # Removed: file does not exist
# require_relative 'vortex/math/golden_ratio' # Removed: file does not exist
require_relative 'math/constants'
require_relative 'math/geometry'
require_relative 'math/cosmic'
require_relative 'math/coil'
require_relative 'math/aperture'
require_relative 'math/sunflower'

module Zeropoint
  # Math: Central mathematical module for all representations in ZeroPoint
  #
  # Provides unified access to vortex math, toroidal geometry, golden ratio,
  # physical constants, cosmic/void helpers, and coil winding logic.
  #
  # == Usage Examples
  #   Zeropoint::Math::Vortex.digital_root(123)
  #   Zeropoint::Math::Vortex::Torus.doubling_sequence(1, 9)
  #   Zeropoint::Math.golden_ratio
  #   Zeropoint::Math.sqrt(2)
  #   Zeropoint::Math::Constants::C
  #   Zeropoint::Math::Geometry.torus_volume(2, 0.5)
  #   Zeropoint::Math::Cosmic.void
  #   Zeropoint::Math::Coil.winding_sequence(12, 5)
  #
  module Math
    # == Golden Ratio Submodule
    module GoldenRatio
      extend self
      def golden_rectangle(width)
        [width, width * Zeropoint::Math.golden_ratio]
      end
      def golden_spiral_radius(angle_deg)
        a = 1.0
        b = Math.log(Zeropoint::Math.golden_ratio) / (::Math::PI / 2)
        a * Math.exp(b * angle_deg * ::Math::PI / 180)
      end
    end

    # == Vortex Math
    # Provides digital root, toroidal, and golden ratio math.
    #
    # Example:
    #   Zeropoint::Math::Vortex.digital_root(123) #=> 6
    module Vortex
      extend ::Zeropoint::Vortex::Math
      Torus = ::Zeropoint::Math::Geometry
      GoldenRatio = ::Zeropoint::Math::GoldenRatio
      def self.pi
        ::Zeropoint::Math.pi
      end
      def self.e
        ::Zeropoint::Math.e
      end
      def self.golden_rectangle(width)
        # Returns [width, width * golden_ratio]
        [width, width * ::Zeropoint::Math.golden_ratio]
      end
      def self.golden_spiral_radius(angle_deg)
        # Returns the radius at a given angle in a golden spiral
        a = 1.0
        b = Math.log(::Zeropoint::Math.golden_ratio) / (::Math::PI / 2)
        a * Math.exp(b * angle_deg * ::Math::PI / 180)
      end
    end

    # == High-level Mathematical Constants
    # Golden ratio, pi, e
    #
    # Example:
    #   Zeropoint::Math.golden_ratio #=> 1.618...
    def self.golden_ratio
      1.618033988749895
    end
    def self.pi
      ::Math::PI
    end
    def self.e
      ::Math::E
    end

    # == Fallback to Ruby's Math
    # Delegates standard math functions to Ruby's Math module.
    #
    # Example:
    #   Zeropoint::Math.sqrt(2) #=> 1.414...
    def self.sin(x)
      ::Math.sin(x)
    end
    def self.cos(x)
      ::Math.cos(x)
    end
    def self.tan(x)
      ::Math.tan(x)
    end
    def self.asin(x)
      ::Math.asin(x)
    end
    def self.acos(x)
      ::Math.acos(x)
    end
    def self.atan(x)
      ::Math.atan(x)
    end
    def self.atan2(y, x)
      ::Math.atan2(y, x)
    end
    def self.exp(x)
      ::Math.exp(x)
    end
    def self.log(x, base = ::Math::E)
      ::Math.log(x, base)
    end
    def self.log10(x)
      ::Math.log10(x)
    end
    def self.log2(x)
      ::Math.log2(x)
    end
    def self.sqrt(x)
      ::Math.sqrt(x)
    end
    def self.cbrt(x)
      ::Math.cbrt(x)
    end
    def self.pow(x, y)
      ::Math.pow(x, y)
    end
    def self.sinh(x)
      ::Math.sinh(x)
    end
    def self.cosh(x)
      ::Math.cosh(x)
    end
    def self.tanh(x)
      ::Math.tanh(x)
    end
    def self.asinh(x)
      ::Math.asinh(x)
    end
    def self.acosh(x)
      ::Math.acosh(x)
    end
    def self.atanh(x)
      ::Math.atanh(x)
    end
    def self.abs(x)
      ::Math.abs(x)
    end
    def self.ceil(x)
      ::Math.ceil(x)
    end
    def self.floor(x)
      ::Math.floor(x)
    end
    def self.round(x, digits = 0)
      ::Math.round(x, digits)
    end
    def self.max(*args)
      ::Math.max(*args)
    end
    def self.min(*args)
      ::Math.min(*args)
    end
    def self.random
      ::Math.random
    end
    def self.method_missing(method_name, *args, &block)
      if ::Math.respond_to?(method_name)
        ::Math.public_send(method_name, *args, &block)
      else
        super
      end
    end
    def self.respond_to_missing?(method_name, include_private = false)
      ::Math.respond_to?(method_name, include_private) || super
    end

    # == DRY Aliases (Unified Math API)
    #
    # Example:
    #   Zeropoint::Math.dr(123)         #=> 6
    #   Zeropoint::Math.doubling(7)     #=> 5
    #   Zeropoint::Math.axis(9)         #=> :axis_9
    #   Zeropoint::Math.fib(10)         #=> 55
    #   Zeropoint::Math.phi             #=> 1.618...
    #   Zeropoint::Math.golden_angle_n  #=> 137.5...
    #   Zeropoint::Math.harmonic_of(2, 3) #=> 6.0
    #   Zeropoint::Math.phase_of(2)     #=> 180
    #   Zeropoint::Math.is_prime?(7)    #=> true
    #   Zeropoint::Math.primes_list(5)  #=> [2, 3, 5, 7, 11]
    def self.dr(n) = Vortex.digital_root(n)
    def self.doubling(n) = Vortex.toroidal_doubling(n)
    def self.axis(n) = Vortex.axis_state(n)
    def self.fib(n) = Vortex.fibonacci(n)
    def self.phi = golden_ratio
    def self.golden_angle_n(n = 1) = Vortex.golden_angle(n)
    def self.harmonic_of(base, n) = Vortex.harmonic(base, n)
    def self.phase_of(step) = Vortex.phase(step)
    def self.is_prime?(n) = Vortex.prime?(n)
    def self.primes_list(k) = Vortex.primes(k)

    # == Constants Submodule
    # Physical and mathematical constants.
    #
    # Example:
    #   Zeropoint::Math::Constants::C #=> 299_792_458.0
    #   Zeropoint::Math::Constants::PHI #=> 1.618...

    # == Geometry Submodule
    # Toroidal and geometric helpers.
    #
    # Example:
    #   Zeropoint::Math::Geometry.torus_volume(2, 0.5) #=> 9.869...
    #   Zeropoint::Math::Geometry.peg_coordinates(12, radius: 1.0)

    # == Cosmic Submodule
    # Void, full, singularity, and cosmic helpers.
    #
    # Example:
    #   Zeropoint::Math::Cosmic.void #=> 0.0
    #   Zeropoint::Math::Cosmic.full #=> 1.618...
    #   Zeropoint::Math::Cosmic.singularity #=> Infinity
    #   Zeropoint::Math::Cosmic.is_void?(nil) #=> true

    # == Coil Submodule
    # Toroidal/star/vortex coil winding logic.
    #
    # Example:
    #   Zeropoint::Math::Coil.winding_sequence(12, 5) #=> [1, 6, 11, 4, ...]
    #   Zeropoint::Math::Coil.peg_coordinates(12, radius: 1.0)
    #   Zeropoint::Math::Coil.winding_segments([1, 6, 11, ...])

    # == Aperture Submodule
    # Models the Primal Point of Unity (zero point) as the gateway between the unmanifest and manifest.
    # Provides methods for identifying the aperture, mapping the W-axis, and accessing metaphysical insights.
    #
    # Example:
    #   Zeropoint::Math::Aperture.aperture?(18)         #=> true
    #   Zeropoint::Math::Aperture.w_axis_sequence(0..27) #=> [0, 9, 18, 27]
    #   Zeropoint::Math::Aperture.insights

    # == Sunflower Submodule
    # Models the Holographic Toroid Map (sunflower) as the up/down duality pattern and preferred frame of reference for the universe.
    # Provides methods for generating the up/down structure and accessing metaphysical insights.
    #
    # Example:
    #   Zeropoint::Math::Sunflower.up_down_pattern(rows: 4, cols: 4)
    #   Zeropoint::Math::Sunflower.insights
  end
end
