# frozen_string_literal: true

# Zeropoint::OpenGraph
#
# Provides a universal .to_open_graph method for any object.
# Embodies the void principle: "Every object contains the infinite potential for sharing."
#
# COSMIC KNOWLEDGE: Open Graph is the universal language for sharing objects across the web.
# This module ensures every object can manifest its essence as Open Graph meta-data.
#
# @example
#   user = User.first
#   user.to_open_graph
#   # => { og:title: "User: Alice", og:type: "profile", og:url: "...", ... }
#
module Zeropoint
  module OpenGraph
    DEFAULTS = {
      "og:type": 'object',
      "og:title": 'Untitled',
      "og:description": 'No description provided.',
      "og:url": '',
      "og:image": '',
      "og:site_name": 'Zeropoint',
      "og:locale": 'en_US',
    }.freeze

    # Generates an Open Graph hash for the object.
    # @return [Hash] Open Graph properties
    # @metaphysics Encodes the object's essence for universal sharing.
    def to_open_graph(overrides = {})
      props = open_graph_properties
      Zeropoint::OpenGraph::DEFAULTS.merge(props).merge(overrides)
    end

    # Override this in your model for custom Open Graph properties.
    # @return [Hash] Custom Open Graph properties
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
