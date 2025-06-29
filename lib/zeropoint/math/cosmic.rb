# frozen_string_literal: true

module Zeropoint
  module Math
    module Cosmic
      def self.void = 0.0
      def self.full = Zeropoint::Math::Constants::PHI
      def self.singularity = Float::INFINITY
      def self.unity = 1.0
      def self.empty = void
      def self.is_void?(x)
        x.nil? || x == 0 || x == '' || x == [] || x == {}
      end
      def self.is_infinite?(x)
        x == Float::INFINITY || x == -Float::INFINITY
      end
      def self.cycle(n, mod = 9)
        n % mod == 0 ? mod : n % mod
      end
    end
  end
end
