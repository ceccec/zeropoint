# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'

module Zeropoint
  module Vortex
    # Math: Core vortex mathematics for digital root, toroidal flow, polarity, and spirals
    module Math
      extend self

      # === AXIS NUMBERS (ENV -> Config -> Module) ===
      # Priority: ENV['ZEROPONT_AXIS_NUMBERS'] > config/zeropoint.yml > default
      AXIS_NUMBERS = (
        if ENV['ZEROPONT_AXIS_NUMBERS']
          ENV['ZEROPONT_AXIS_NUMBERS'].split(',').map(&:to_i)
        elsif defined?(Zeropoint) && Zeropoint.respond_to?(:config) && Zeropoint.config.respond_to?(:math)
          # Try to access math configuration safely
          begin
            Zeropoint.config.math&.axis_numbers || [ 3, 6, 9 ]
          rescue NoMethodError
            [ 3, 6, 9 ]
          end
        else
          [ 3, 6, 9 ]
        end
      ).freeze

      # === RODIN VORTEX MATH (MOD 9, DIGITAL ROOT) ===
      # Returns the digital root (mod 9, 1-9 cycle) of a number
      def digital_root(n)
        n = n.to_i.abs
        return 9 if n == 0
        r = n % 9
        r.zero? ? 9 : r
      end

      # Alias for mod_9 for ::Math-like naming
      alias mod_9 digital_root

      # Returns the full digital root cycle for a sequence
      def digital_root_cycle(sequence)
        sequence.map { |n| digital_root(n) }
      end

      # === TOROIDAL FLOW ===
      # Returns the next value in a doubling/halving toroidal sequence (mod 9)
      def toroidal_doubling(n)
        digital_root(n * 2)
      end
      alias doubling toroidal_doubling

      def toroidal_halving(n)
        # Inverse of doubling in mod 9 (finds a number x such that digital_root(x*2) == n)
        (1..9).find { |x| toroidal_doubling(x) == digital_root(n) } || 0
      end
      alias halving toroidal_halving

      # Returns the 3, 6, 9 axis state for a given number
      def axis_state(n)
        case digital_root(n)
        when 3 then :axis_3
        when 6 then :axis_6
        when 9 then :axis_9
        else :off_axis
        end
      end

      # === POLARITY ===
      # Returns +1 for even, -1 for odd (simple polarity)
      def polarity(n)
        n.to_i.even? ? +1 : -1
      end

      # === FIBONACCI & GOLDEN RATIO ===
      # Returns the nth Fibonacci number
      def fibonacci(n)
        return 0 if n <= 0
        return 1 if n == 1
        a = 0
        b = 1
        (2..n).each { a, b = b, a + b }
        b
      end

      # Returns the golden ratio (phi)
      def phi
        (1 + ::Zeropoint::Math.sqrt(5)) / 2
      end

      # Returns the nth golden angle (in degrees)
      def golden_angle(n = 1)
        (360.0 * (1 - 1.0 / phi) * n) % 360
      end

      # === HARMONICS & RESONANCE ===
      # Returns the nth harmonic (frequency multiple)
      def harmonic(base, n)
        base.to_f * n.to_f
      end

      # Returns the phase (0, 90, 180, 270) for a given step in a 4-phase cycle
      def phase(step)
        %w[0 90 180 270][step % 4].to_i
      end

      # === PRIMES ===
      # Returns true if n is prime
      def prime?(n)
        n = n.to_i
        return false if n < 2
        (2..::Zeropoint::Math.sqrt(n)).none? { |i| n % i == 0 }
      end

      # Returns the first k primes
      def primes(k)
        primes = []
        n = 2
        while primes.length < k
          primes << n if prime?(n)
          n += 1
        end
        primes
      end

      # === ::Math-like naming for DRYness ===
      # Provide delegator methods for standard math names
      def sqrt(*args, &block)
        ::Zeropoint::Math.sqrt(*args, &block)
      end

      def cbrt(*args, &block)
        ::Zeropoint::Math.cbrt(*args, &block)
      end

      def pow(*args, &block)
        ::Zeropoint::Math.pow(*args, &block)
      end

      def sin(*args, &block)
        ::Zeropoint::Math.sin(*args, &block)
      end

      def cos(*args, &block)
        ::Zeropoint::Math.cos(*args, &block)
      end

      def tan(*args, &block)
        ::Zeropoint::Math.tan(*args, &block)
      end

      def asin(*args, &block)
        ::Zeropoint::Math.asin(*args, &block)
      end

      def acos(*args, &block)
        ::Zeropoint::Math.acos(*args, &block)
      end

      def atan(*args, &block)
        ::Zeropoint::Math.atan(*args, &block)
      end

      def atan2(*args, &block)
        ::Zeropoint::Math.atan2(*args, &block)
      end

      def exp(*args, &block)
        ::Zeropoint::Math.exp(*args, &block)
      end

      def log10(*args, &block)
        ::Zeropoint::Math.log10(*args, &block)
      end

      def log2(*args, &block)
        ::Zeropoint::Math.log2(*args, &block)
      end

      def abs(*args, &block)
        ::Zeropoint::Math.abs(*args, &block)
      end

      def ceil(*args, &block)
        ::Zeropoint::Math.ceil(*args, &block)
      end

      def floor(*args, &block)
        ::Zeropoint::Math.floor(*args, &block)
      end

      def random(*args, &block)
        ::Zeropoint::Math.random(*args, &block)
      end

      # === DRY ALIASES FOR VORTEX MATH ===
      def dr(n) = digital_root(n)
      def cycle(sequence) = digital_root_cycle(sequence)
      def doubling(n) = toroidal_doubling(n)
      def halving(n) = toroidal_halving(n)
      def axis(n) = axis_state(n)
      def polarity_of(n) = polarity(n)
      def fib(n) = fibonacci(n)
      def golden_angle_n(n = 1) = golden_angle(n)
      def harmonic_of(base, n) = harmonic(base, n)
      def phase_of(step) = phase(step)
      def is_prime?(n) = prime?(n)
      def primes_list(k) = primes(k)
    end
  end
end
