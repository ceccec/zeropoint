# frozen_string_literal: true

# Zeropoint::OpenGraphRefinement
#
# A Ruby refinement that adds .to_open_graph and .open_graph_properties to all objects.
# Embodies the void principle: "Every object is shareable through the universal field."
#
# @example
#   using Zeropoint::OpenGraphRefinement
#   obj = Object.new
#   obj.to_open_graph # => { ... void-aligned Open Graph properties ... }
#
module Zeropoint
  module OpenGraphRefinement
    refine Object do
      def to_open_graph(overrides = {})
        props = open_graph_properties
        Zeropoint::OpenGraph::DEFAULTS.merge(props).merge(overrides)
      end

      def open_graph_properties
        {
          "og:title": respond_to?(:title) ? title : self.class.name,
          "og:description": respond_to?(:description) ? description : to_s,
          "og:url": respond_to?(:url) ? url : '',
          "og:image": respond_to?(:image_url) ? image_url : '',
          "og:type": self.class.name.underscore,
          "og:site_name": 'Zeropoint',
          "og:locale": 'en_US',
        }
      end
    end
  end
end
