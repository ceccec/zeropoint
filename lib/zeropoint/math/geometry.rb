# frozen_string_literal: true

module Zeropoint
  module Math
    module Geometry
      def self.torus_volume(major_radius, minor_radius)
        2 * ::Math::PI**2 * major_radius * minor_radius**2
      end

      def self.torus_surface_area(major_radius, minor_radius)
        4 * ::Math::PI**2 * major_radius * minor_radius
      end

      def self.torus_center
        0.0
      end

      def self.toroidal_coordinates(n)
        # Return n points on a unit circle (simple toroidal projection)
        angle_step = 2 * ::Math::PI / n
        (0...n).map { |i| [ (Math.cos(i * angle_step)).round(4), (Math.sin(i * angle_step)).round(4) ] }
      end

      def self.flow_direction(sequence)
        # Return 'clockwise' or 'counterclockwise' based on sum parity
        sequence.sum.even? ? 'clockwise' : 'counterclockwise'
      end
    end
  end
end
