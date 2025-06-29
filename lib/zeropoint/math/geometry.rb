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
    end
  end
end
